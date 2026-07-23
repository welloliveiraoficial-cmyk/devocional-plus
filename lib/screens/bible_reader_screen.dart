import 'package:flutter/material.dart';
import '../services/bible_service.dart';
import '../theme/app_theme.dart';

class BibleReaderScreen extends StatefulWidget {
  final BibleBook book;
  final int chapter;
  const BibleReaderScreen({super.key, required this.book, required this.chapter});

  @override
  State<BibleReaderScreen> createState() => _BibleReaderScreenState();
}

class _BibleReaderScreenState extends State<BibleReaderScreen> {
  List<BibleVerse> _verses = [];
  bool _loading = true;
  String? _error;
  late int _chapter;

  @override
  void initState() {
    super.initState();
    _chapter = widget.chapter;
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final verses = await BibleService.getChapter(widget.book.abbrev, _chapter);
      setState(() {
        _verses = verses;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Não foi possível carregar este capítulo.';
        _loading = false;
      });
    }
  }

  void _goToChapter(int newChapter) {
    if (newChapter < 1 || newChapter > widget.book.chapters) return;
    setState(() => _chapter = newChapter);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book.name} $_chapter'),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(_error!)))
              : ListView(
                  padding: const EdgeInsets.all(24),
                  children: _verses
                      .map((v) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 15, height: 1.7, color: Color(0xFF2A3A4F)),
                                children: [
                                  TextSpan(
                                    text: '${v.number} ',
                                    style: const TextStyle(color: AppColors.bronze, fontWeight: FontWeight.bold, fontSize: 11),
                                  ),
                                  TextSpan(text: v.text),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
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
              TextButton(
                onPressed: _chapter < widget.book.chapters ? () => _goToChapter(_chapter + 1) : null,
                child: const Row(
                  children: [Text('Próximo'), Icon(Icons.chevron_right)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
