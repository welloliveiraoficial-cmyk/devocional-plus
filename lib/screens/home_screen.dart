import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'bible_books_screen.dart';
import 'devotionals_screen.dart';

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
          if (index == 2) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DevotionalsScreen()));
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
                const S
