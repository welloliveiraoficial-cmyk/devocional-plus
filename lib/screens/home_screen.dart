import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'bible_books_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _saudacao() {
    final hora = DateTime.now().hour;
    if (hora < 12) return 'Bom dia';
    if (hora < 18) return 'Boa tarde';
    return 'Boa noite';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(saudacao: _saudacao()),
            const _SectionLabel('Acesso rápido'),
            const _QuickMenu(),
            const _SectionLabel('Seu plano de leitura'),
            const _PlanCard(),
            const _QuoteCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.menu_book_rounded), label: 'Bíblia'),
          NavigationDestination(icon: Icon(Icons.volunteer_activism_rounded), label: 'Devocional'),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Perfil'),
        ],
        onDestinationSelected: (index) {
          if (index == 1) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BibleBooksScreen()));
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Em breve! 🙏')),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String saudacao;
  const _Header({required this.saudacao});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 50, 22, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.navy, AppColors.navy2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            saudacao,
            style: const TextStyle(
              color: AppColors.bronzeSoft,
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Que sua semana seja abençoada',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.bronze.withOpacity(0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'VERSÍCULO DO DIA',
                  style: TextStyle(color: AppColors.bronze, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
                const SizedBox(height: 8),
                const Text(
                  '"Tudo posso naquele que me fortalece."',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 6),
                Text('Filipenses 4:13', style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 12)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _iconBtn(Icons.favorite_border),
                    const SizedBox(width: 10),
                    _iconBtn(Icons.share_outlined),
                    const SizedBox(width: 10),
                    _iconBtn(Icons.copy_outlined),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(icon, size: 14, color: Colors.white),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 12),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.6,
          color: AppColors.navy.withOpacity(0.6),
        ),
      ),
    );
  }
}

class _MenuItemData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  _MenuItemData(this.icon, this.label, this.onTap);
}

class _QuickMenu extends StatelessWidget {
  const _QuickMenu();

  void _emBreve(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Em breve! 🙏')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itens = <_MenuItemData>[
      _MenuItemData(Icons.menu_book_rounded, 'Bíblia', () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BibleBooksScreen()));
      }),
      _MenuItemData(Icons.volunteer_activism_rounded, 'Devocionais', () => _emBreve(context)),
      _MenuItemData(Icons.edit_note_rounded, 'Diário', () => _emBreve(context)),
      _MenuItemData(Icons.calendar_month_rounded, 'Plano', () => _emBreve(context)),
      _MenuItemData(Icons.favorite_rounded, 'Favoritos', () => _emBreve(context)),
      _MenuItemData(Icons.share_rounded, 'Compartilhar', () => _emBreve(context)),
      _MenuItemData(Icons.search_rounded, 'Pesquisar', () => _emBreve(context)),
      _MenuItemData(Icons.settings_rounded, 'Ajustes', () => _emBreve(context)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.85,
        children: itens.map((item) => _MenuItem(data: item)).toList(),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final _MenuItemData data;
  const _MenuItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: data.onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppColors.navy.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 6))],
            ),
            child: Icon(data.icon, color: AppColors.navy, size: 22),
          ),
          const SizedBox(height: 8),
          Text(data.label, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.navy), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: AppColors.navy.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Plano de 30 dias', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.navy)),
              Text('42%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.bronze)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.42,
              minHeight: 8,
              backgroundColor: AppColors.skySoft,
              valueColor: const AlwaysStoppedAnimation(AppColors.bronze),
            ),
          ),
          const SizedBox(height: 8),
          Text('Dia 13 de 30 · 6 dias seguidos 🔥', style: TextStyle(fontSize: 11, color: AppColors.navy.withOpacity(0.6))),
        ],
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(22, 22, 22, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.skySoft, Color(0xFFEEF4FB)]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: const [
          Text(
            '"A oração não muda Deus, mas muda quem ora."',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, color: AppColors.navy),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text('Frase Inspirada', style: TextStyle(fontSize: 11, color: Colors.black45)),
        ],
      ),
    );
  }
}
