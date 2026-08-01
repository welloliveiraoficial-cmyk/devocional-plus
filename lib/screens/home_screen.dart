import 'package:flutter/material.dart';

import '../widgets/home/home_header.dart';
import '../widgets/home/daily_verse_card.dart';
import '../widgets/home/quick_menu.dart';
import '../widgets/home/reading_plan_card.dart';
import '../widgets/home/inspiration_card.dart';

import '../theme/app_theme.dart';

import 'bible_books_screen.dart';
import 'devotionals_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _saudacao() {
    final hora = DateTime.now().hour;

    if (hora < 12) {
      return 'Bom dia';
    }

    if (hora < 18) {
      return 'Boa tarde';
    }

    return 'Boa noite';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,

      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(
              saudacao: _saudacao(),
            ),

            const DailyVerseCard(),

            const Padding(
              padding: EdgeInsets.only(
                top: 24,
              ),
              child: Text(
                'ACESSO RÁPIDO',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),

            const SizedBox(height: 12),

            const QuickMenu(),

            const ReadingPlanCard(),

            const InspirationCard(),

            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'Início',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.menu_book_rounded,
            ),
            label: 'Bíblia',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.volunteer_activism_rounded,
            ),
            label: 'Devocional',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.person_rounded,
            ),
            label: 'Perfil',
          ),
        ],

        onDestinationSelected: (index) {

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const BibleBooksScreen(),
              ),
            );
          }

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const DevotionalsScreen(),
              ),
            );
          }

          if (index == 3) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  'Perfil em breve 🙏',
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
