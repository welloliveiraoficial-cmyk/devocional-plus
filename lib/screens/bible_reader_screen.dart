import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/bible_service.dart';
import '../theme/app_theme.dart';
import '../theme/app_decorations.dart';

class BibleReaderScreen extends StatefulWidget {
  final BibleBook book;
  final int chapter;
  const BibleReaderScreen({super.key, required this.book, required this.chapter});

  @override
  State<BibleReaderScreen> createState() => _BibleReaderScreenState();
}

class _BibleReaderScreenState extends State<BibleReaderScreen> with SingleTickerProviderStateMixin {
  List<BibleVerse> _verses = [];
  bool _loading = true;
  String? _error;
  late int _chapter;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _chapter = widget.chapter;
    _controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final verses = await BibleService.getChapter(widget.book.abbrev, _chapter);
      if (mounted) {
        setState(() { _verses = verses; _loading = false; });
        _controller.forward(from: 0);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'O serviço da Bíblia está instável no momento.\nToque para tentar novamente.';
          _loading = false;
        });
      }
    }
  }

  void _goToChapter(int newChapter) {
    if (newChapter < 1 || newChapter > widget.book.chapters) return;
    AppHaptics.tap();
    setState(() => _chapter = newChapter);
    _load();
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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text('${widget.book.name} $_chapter', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600, fontSize: 19)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
          : _error != null
              ? _errorView()
              : FadeTransition(
                  opacity: _animation,
                  child: ListView(
                    padding: const EdgeInsets.all(22),
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                GoldenGlow(
                                  size: 54, opacity: 0.35,
                                  child: const Icon(Icons.auto_stories_rounded, color: AppColors.goldBright, size: 32),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    '${widget.book.name}\nCapítulo $_chapter',
                                    style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(top: 8, right: 26, child: BibleRibbon()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ..._verses.map((verse) => _VerseCard(verse: verse)),
                    ],
                  ),
                ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: _chapter > 1 ? () => _goToChapter(_chapter - 1) : null,
                icon: const Icon(Icons.chevron_left),
                label: const Text('Anterior'),
              ),
              TextButton.icon(
                onPressed: _chapter < widget.book.chapters ? () => _goToChapter(_chapter + 1) : null,
                icon: const Icon(Icons.chevron_right),
                label: const Text('Próximo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _errorView() {
    return Center(
      child: InkWell(
        onTap: _load,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off_rounded, size: 45, color: AppColors.ink.withOpacity(0.35)),
              const SizedBox(height: 15),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              const Text('🔄 Tentar novamente', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerseCard extends StatelessWidget {
  final BibleVerse verse;
  const _VerseCard({required this.verse});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: '${verse.number}  ', style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.bold)),
            TextSpan(text: verse.text, style: GoogleFonts.lora(color: AppColors.ink, fontSize: 16, height: 1.7)),
          ],
        ),
      ),
    );
  }
}
