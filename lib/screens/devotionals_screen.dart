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
      appBar: AppBar(
        title: const Text('Devocionais'),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: devotionalThemes.map((theme) => _ThemeSection(theme: theme)).toList(),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(
            theme.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
              color: AppColors.navy.withOpacity(0.6),
            ),
          ),
        ),
        SizedBox(
          height: 150,
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
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DevotionalReaderScreen(devotional: devotional),
        ));
      },
      child: Container(
        width: 190,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: AppColors.navy.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              devotional.theme.toUpperCase(),
              style: const TextStyle(color: AppColors.bronze, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.6),
            ),
            const SizedBox(height: 8),
            Text(
              devotional.title,
              style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: AppColors.navy),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Icon(Icons.schedule, size: 12, color: AppColors.navy.withOpacity(0.4)),
                const SizedBox(width: 4),
                Text(
                  '${devotional.readingMinutes} min',
                  style: TextStyle(fontSize: 11, color: AppColors.navy.withOpacity(0.5)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
