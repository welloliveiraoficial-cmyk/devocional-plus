import 'package:flutter/material.dart';
import '../data/devotionals_data.dart';
import '../models/devotional.dart';
import '../theme/app_theme.dart';
import 'devotional_reader_screen.dart';

class DevotionalsScreen extends StatelessWidget {
  const DevotionalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        title: const Text('Devocionais'),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.navy,
                  AppColors.navy2,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Momento com Deus',
                  style: TextStyle(
                    color: AppColors.bronzeSoft,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Uma palavra para fortalecer sua fé hoje.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Escolha uma reflexão e permita que Deus fale ao seu coração.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          ...devotionalThemes.map(
            (theme) => _ThemeSection(theme: theme),
          ),
        ],
      ),
    );
  }
}

class _ThemeSection extends StatelessWidget {
  final String theme;

  const _ThemeSection({
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final items =
        devotionals.where((d) => d.theme == theme).toList();

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.fromLTRB(22, 12, 22, 10),
          child: Text(
            theme.toUpperCase(),
            style: TextStyle(
              color: AppColors.navy.withOpacity(0.65),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),

        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _DevotionalCard(
                devotional: items[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DevotionalCard extends StatelessWidget {
  final Devotional devotional;

  const _DevotionalCard({
    required this.devotional,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                DevotionalReaderScreen(
              devotional: devotional,
            ),
          ),
        );
      },
      child: Container(
        width: 220,
        margin:
            const EdgeInsets.symmetric(horizontal: 7),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color:
                  AppColors.navy.withOpacity(0.08),
              blurRadius: 18,
              offset:
                  const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color:
                    AppColors.bronze.withOpacity(0.15),
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Text(
                devotional.theme,
                style: const TextStyle(
                  color: AppColors.bronze,
                  fontSize: 10,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 14),

            Text(
              devotional.title,
              maxLines: 3,
              overflow:
                  TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
                height: 1.3,
              ),
            ),

            const Spacer(),

            Row(
              children: [
                const Icon(
                  Icons.menu_book_rounded,
                  size: 14,
                  color: AppColors.bronze,
                ),
                const SizedBox(width: 6),
                Text(
                  '${devotional.readingMinutes} minutos de leitura',
                  style: TextStyle(
                    color:
                        AppColors.navy.withOpacity(0.55),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
