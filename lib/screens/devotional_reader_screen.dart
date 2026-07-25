import 'package:flutter/material.dart';
import '../models/devotional.dart';
import '../theme/app_theme.dart';

class DevotionalReaderScreen extends StatelessWidget {
  final Devotional devotional;
  const DevotionalReaderScreen({super.key, required this.devotional});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.navy,
            foregroundColor: Colors.white,
            expandedHeight: 160,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.navy, AppColors.navy2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'TEMA: ${devotional.theme.toUpperCase()}',
                      style: const TextStyle(color: AppColors.bronze, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      devotional.title,
                      style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w600, height: 1.3),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${devotional.readingMinutes} min de leitura',
                      style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.bronzeSoft,
                      borderRadius: BorderRadius.circular(10),
                      border: const Border(left: BorderSide(color: AppColors.bronze, width: 3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '"${devotional.verseText}"',
                          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14.5, color: Color(0xFF5A4632), height: 1.5),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          devotional.verseRef,
                          style: const TextStyle(fontSize: 12, color: Color(0xFF5A4632), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  _SectionTitle('Reflexão'),
                  _BodyText(devotional.reflection),
                  _SectionTitle('Aplicação Prática'),
                  _BodyText(devotional.application),
                  _SectionTitle('Oração'),
                  _BodyText(devotional.prayer),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _actionButton(Icons.favorite_border, 'Favoritar'),
                      const SizedBox(width: 16),
                      _actionButton(Icons.share_outlined, 'Compartilhar'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: null,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.navy,
        side: BorderSide(color: AppColors.navy.withOpacity(0.2)),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8, color: AppColors.bronze),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  final String text;
  const _BodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, height: 1.7, color: Color(0xFF3A4A5F)),
    );
  }
}
