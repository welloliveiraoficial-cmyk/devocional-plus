import 'package:flutter/material.dart';
import '../services/bible_service.dart';
import '../theme/app_theme.dart';
import 'bible_chapter_list_screen.dart';

class BibleBooksScreen extends StatefulWidget {
  const BibleBooksScreen({super.key});

  @override
  State<BibleBooksScreen> createState() => _BibleBooksScreenState();
}

class _BibleBooksScreenState extends State<BibleBooksScreen> {
  List<BibleBook> _books = [];
  List<BibleBook> _filtered = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final books = await BibleService.getBooks();
      setState(() {
        _books = books;
        _filtered = books;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Não foi possível carregar a Bíblia. Verifique sua internet.';
        _loading = false;
      });
    }
  }

  void _filter(String query) {
    setState(() {
      _filtered = _books
          .where((b) => b.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bíblia Sagrada'),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: _filter,
              decoration: InputDecoration(
                hintText: 'Buscar livro...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.skySoft,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(_error!, textAlign: TextAlign.center),
                        ),
                      )
                    : ListView(
                        children: [
                          _testamentSection('Antigo Testamento', 'VT'),
                          _testamentSection('Novo Testamento', 'NT'),
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  Widget _testamentSection(String label, String code) {
    final books = _filtered.where((b) => b.testament == code).toList();
    if (books.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.navy.withOpacity(0.6),
              letterSpacing: 0.6,
            ),
          ),
        ),
        ...books.map((b) => ListTile(
              title: Text(b.name),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BibleChapterListScreen(book: b),
                ));
              },
            )),
      ],
    );
  }
}
