import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../theme/app_decorations.dart';
import '../services/bible_service.dart';
import 'bible_chapter_list_screen.dart';

class BibleBooksScreen extends StatefulWidget {
  const BibleBooksScreen({super.key});

  @override
  State<BibleBooksScreen> createState() => _BibleBooksScreenState();
}

class _BibleBooksScreenState extends State<BibleBooksScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<BibleBook> books = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _loadBooks();
    _controller.forward();
  }

  Future<void> _loadBooks() async {
    final result = await BibleService.getBooks();
    if (mounted) setState(() { books = result; loading = false; });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _animation,
        child: loading
            ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 55, 22, 28),
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
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 4),
                            GoldenGlow(
                              size: 50,
                              opacity: 0.35,
                              child: Container(
                                width: 40, height: 40,
                                decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.16), shape: BoxShape.circle),
                                child: const Icon(Icons.menu_book_rounded, color: AppColors.goldBright, size: 20),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text('Bíblia Sagrada', style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        const Text('Escolha um livro para começar sua leitura.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
                      itemCount: books.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.30,
                      ),
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(22),
                          onTap: () {
                            AppHaptics.tap();
                            Navigator.push(context, FadeSlideRoute(page: BibleChapterListScreen(book: book)));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8))],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 42, height: 42,
                                  decoration: const BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
                                  child: const Icon(Icons.menu_book_rounded, color: AppColors.gold),
                                ),
                                const SizedBox(height: 12),
                                Text(book.name, style: const TextStyle(color: AppColors.ink, fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(book.testament, style: TextStyle(color: AppColors.inkLight, fontSize: 11)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
