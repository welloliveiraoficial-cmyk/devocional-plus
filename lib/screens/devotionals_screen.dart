import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/devotionals_data.dart';
import '../models/devotional.dart';
import '../theme/app_theme.dart';
import '../theme/app_decorations.dart';
import 'devotional_reader_screen.dart';

class DevotionalsScreen extends StatelessWidget {
  const DevotionalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            padding: const EdgeInsets.fromLTRB(24, 55, 24, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                    ),
                    const Text('MOMENTO COM DEUS', style: TextStyle(color: AppColors.goldSoft, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Uma palavra para fortalecer sua fé hoje.',
                  style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600, height: 1.3),
                ),
                const SizedBox(height: 10),
                const Text('Escolha uma reflexão e permita que Deus fale ao seu coração.', style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4)),
              ],
            ),
          ),
          ...devotionalThemes.map((theme) => _ThemeSection(theme: theme)),
        ],
      ),
    );
  }
}

class _ThemeSection extends StatelessWidget {
  final String theme;
  const _ThemeSection({required this.theme});

  @override
  Widget build(BuildContext context) {
    final items = devotionals.where((d) => d.theme == theme).toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(theme, padding: const EdgeInsets.fromLTRB(22, 18, 22, 10)),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) => _DevotionalCard(devotional: items[index]),
          ),
        ),
      ],
    );
  }
}

class _DevotionalCard extends StatelessWidget {
  final Devotional devotional;
  const _DevotionalCard({required this.devotional});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        AppHaptics.tap();
        Navigator.of(context).push(FadeSlideRoute(page: DevotionalReaderScreen(devotional: devotional)));
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.symmetric(horizontal: 7),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.08), blurRadius: 18, offset: const Offset(0, 8))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
              child: Text(devotional.theme, style: const TextStyle(color: AppColors.gold, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 14),
            Text(
              devotional.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.playfairDisplay(color: AppColors.ink, fontSize: 16, fontWeight: FontWeight.w600, height: 1.3),
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.menu_book_rounded, size: 14, color: AppColors.gold),
                const SizedBox(width: 6),
                Text('${devotional.readingMinutes} minutos de leitura', style: TextStyle(color: AppColors.inkLight, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
