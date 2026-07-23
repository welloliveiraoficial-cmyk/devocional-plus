import 'package:flutter/material.dart';
import '../services/bible_service.dart';
import '../theme/app_theme.dart';
import 'bible_reader_screen.dart';

class BibleChapterListScreen extends StatelessWidget {
  final BibleBook book;
  const BibleChapterListScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: book.chapters,
        itemBuilder: (context, index) {
          final chapterNumber = index + 1;
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BibleReaderScreen(book: book, chapter: chapterNumber),
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: AppColors.navy.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              alignment: Alignment.center,
              child: Text('$chapterNumber', style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.navy)),
            ),
          );
        },
      ),
    );
  }
}
