import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_decorations.dart';
import '../../screens/bible_books_screen.dart';
import '../../screens/devotionals_screen.dart';
import '../../screens/settings_screen.dart';
import '../../screens/prayer_journal_screen.dart';

class QuickMenu extends StatefulWidget {
  const QuickMenu({super.key});

  @override
  State<QuickMenu> createState() => _QuickMenuState();
}

class _QuickMenuState extends State<QuickMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _go(BuildContext context, Widget screen) {
    AppHaptics.tap();
    Navigator.push(context, FadeSlideRoute(page: screen));
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuData(Icons.menu_book_rounded, 'Bíblia', () => _go(context, const BibleBooksScreen())),
      _MenuData(Icons.volunteer_activism_rounded, 'Devocionais', () => _go(context, const DevotionalsScreen())),
      _MenuData(Icons.edit_note_rounded, 'Diário', () => _go(context, const PrayerJournalScreen())),
      _MenuData(Icons.calendar_month_rounded, 'Plano', () {
        AppHaptics.tap();
        _message(context, 'Plano de leitura em breve 📖');
      }),
      _MenuData(Icons.favorite_rounded, 'Favoritos', () {
        AppHaptics.tap();
        _message(context, 'Favoritos em breve ❤️');
      }),
      _MenuData(Icons.share_rounded, 'Compartilhar', () {
        AppHaptics.tap();
        _message(context, 'Compartilhar em breve 📤');
      }),
      _MenuData(Icons.search_rounded, 'Pesquisar', () {
        AppHaptics.tap();
        _message(context, 'Pesquisa em breve 🔎');
      }),
      _MenuData(Icons.settings_rounded, 'Ajustes', () => _go(context, const SettingsScreen())),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 18,
          crossAxisSpacing: 14,
          childAspectRatio: 0.78,
        ),
        itemBuilder: (context, index) {
          final interval = Interval(
            (index / items.length) * 0.6,
            0.4 + (index / items.length) * 0.6,
            curve: Curves.easeOut,
          );
          final animation = CurvedAnimation(parent: _controller, curve: interval);

          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: _MenuItem(data: items[index])),
          );
        },
      ),
    );
  }
}

class _MenuData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  _MenuData(this.icon, this.title, this.onTap);
}

class _MenuItem extends StatelessWidget {
  final _MenuData data;
  const _MenuItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: data.onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(color: AppColors.primary.withOpacity(0.09), blurRadius: 14, offset: const Offset(0, 7)),
              ],
            ),
            child: Icon(data.icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.ink),
          ),
        ],
      ),
    );
  }
}
