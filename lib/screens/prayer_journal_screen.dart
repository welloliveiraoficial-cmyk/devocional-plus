import 'package:flutter/material.dart';
import '../models/prayer_entry.dart';
import '../services/prayer_service.dart';
import '../theme/app_theme.dart';
import 'prayer_entry_screen.dart';

class PrayerJournalScreen extends StatefulWidget {
  const PrayerJournalScreen({super.key});

  @override
  State<PrayerJournalScreen> createState() => _PrayerJournalScreenState();
}

class _PrayerJournalScreenState extends State<PrayerJournalScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<PrayerEntry> _entries = [];
  bool _loading = true;

  final _categories = ['Todos', 'Pedido', 'Agradecimento', 'Testemunho'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _load();
  }

  Future<void> _load() async {
    final entries = await PrayerService.getAll();
    setState(() {
      _entries = entries;
      _loading = false;
    });
  }

  List<PrayerEntry> _filtered(String category) {
    if (category == 'Todos') return _entries;
    return _entries.where((e) => e.category == category).toList();
  }

  Future<void> _openNew() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => const PrayerEntryScreen()),
    );
    if (result == true) _load();
  }

  Future<void> _openEdit(PrayerEntry entry) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => PrayerEntryScreen(entry: entry)),
    );
    if (result == true) _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diário de Oração'),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.bronze,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: _categories.map((c) => Tab(text: c)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.bronze,
        onPressed: _openNew,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: _categories.map((c) => _EntryList(entries: _filtered(c), onTap: _openEdit)).toList(),
            ),
    );
  }
}

class _EntryList extends StatelessWidget {
  final List<PrayerEntry> entries;
  final Function(PrayerEntry) onTap;
  const _EntryList({required this.entries, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            'Nada por aqui ainda.\nToque no + para adicionar.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.navy.withOpacity(0.5)),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            onTap: () => onTap(entry),
            contentPadding: const EdgeInsets.all(14),
            title: Row(
              children: [
                Expanded(
                  child: Text(entry.title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.navy)),
                ),
                if (entry.favorite) const Icon(Icons.favorite, size: 16, color: AppColors.bronze),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                entry.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColors.navy.withOpacity(0.6), fontSize: 13),
              ),
            ),
            trailing: entry.answered
                ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
                : null,
          ),
        );
      },
    );
  }
}
