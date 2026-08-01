import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../screens/bible_books_screen.dart';
import '../../screens/devotionals_screen.dart';
import '../../screens/settings_screen.dart';
import '../../screens/prayer_journal_screen.dart';

class QuickMenu extends StatelessWidget {
  const QuickMenu({super.key});

  void _message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuData(
        Icons.menu_book_rounded,
        'Bíblia',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BibleBooksScreen(),
            ),
          );
        },
      ),
      _MenuData(
        Icons.volunteer_activism_rounded,
        'Devocionais',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DevotionalsScreen(),
            ),
          );
        },
      ),
      _MenuData(
        Icons.edit_note_rounded,
        'Diário',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PrayerJournalScreen(),
            ),
          );
        },
      ),
      _MenuData(
        Icons.calendar_month_rounded,
        'Plano',
        () {
          _message(context, 'Plano de leitura em breve 📖');
        },
      ),
      _MenuData(
        Icons.favorite_rounded,
        'Favoritos',
        () {
          _message(context, 'Favoritos em breve ❤️');
        },
      ),
      _MenuData(
        Icons.share_rounded,
        'Compartilhar',
        () {
          _message(context, 'Compartilhar em breve 📤');
        },
      ),
      _MenuData(
        Icons.search_rounded,
        'Pesquisar',
        () {
          _message(context, 'Pesquisa em breve 🔎');
        },
      ),
      _MenuData(
        Icons.settings_rounded,
        'Ajustes',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SettingsScreen(),
            ),
          );
        },
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 18,
          crossAxisSpacing: 14,
          childAspectRatio: 0.78,
        ),
        itemBuilder: (context, index) {
          return _AnimatedMenuItem(
            data: items[index],
            delay: index * 80,
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

  _MenuData(
    this.icon,
    this.title,
    this.onTap,
  );
}

class _AnimatedMenuItem extends StatefulWidget {
  final _MenuData data;
  final int delay;

  const _AnimatedMenuItem({
    required this.data,
    required this.delay,
  });

  @override
  State<_AnimatedMenuItem> createState() =>
      _AnimatedMenuItemState();
}

class _AnimatedMenuItemState extends State<_AnimatedMenuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );

    Future.delayed(
      Duration(milliseconds: widget.delay),
      () {
        if (mounted) {
          controller.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: widget.data.onTap,
          child: Column(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navy.withOpacity(0.10),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  widget.data.icon,
                  color: AppColors.navy,
                  size: 24,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                widget.data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navy,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
