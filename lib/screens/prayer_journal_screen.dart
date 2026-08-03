import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/prayer_entry.dart';
import '../services/prayer_service.dart';
import '../theme/app_theme.dart';
import '../theme/app_decorations.dart';
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
    setState(() { _entries = entries; _loading = false; });
  }

  List<PrayerEntry> _filtered(String category) {
    if (category == 'Todos') return _entries;
    return _entries.where((e) => e.category == category).toList();
  }

  Future<void> _openNew() async {
    AppHaptics.tap();
    final result = await Navigator.of(context).push<bool>(FadeSlideRoute(page: const PrayerEntryScreen()));
    if (result == true) _load();
  }

  Future<void> _openEdit(PrayerEntry entry) async {
    AppHaptics.tap();
    final result = await Navigator.of(context).push<bool>(FadeSlideRoute(page: PrayerEntryScreen(entry: entry)));
    if (result == true) _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 55, 24, 18),
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
                      const SizedBox(width: 4),
                      Text('Diário de Oração', style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text('Registre seus pedidos, gratidões e testemunhos.', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ),
                  const SizedBox(height: 16),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: AppColors.gold,
                    indicatorWeight: 3,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white54,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    tabs: _categories.map((c) => Tab(text: c)).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: _loading
            ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
            : TabBarView(
                controller: _tabController,
                children: _categories.map((c) => _EntryList(entries: _filtered(c), onTap: _openEdit)).toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        onPressed: _openNew,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _EntryList extends StatelessWidget {
  final List<PrayerEntry> entries;
  final Function(PrayerEntry) onTap;
  const _EntryList({required this.entries, required this.onTap});

  IconData _iconFor(String category) {
    switch (category) {
      case 'Pedido': return Icons.pan_tool_outlined;
      case 'Agradecimento': return Icons.emoji_emotions_outlined;
      case 'Testemunho': return Icons.auto_awesome_outlined;
      default: return Icons.book_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text('Nada por aqui ainda.\nToque no + para adicionar.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.inkLight)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => onTap(entry),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.06), blurRadius: 14, offset: const Offset(0, 6))],
            ),
            child: Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: const BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
                  child: Icon(_iconFor(entry.category), color: AppColors.gold, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(entry.title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.ink))),
                          if (entry.favorite) const Icon(Icons.favorite, size: 16, color: AppColors.gold),
                        ],
                      ),
                      if (entry.description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(entry.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.inkLight, fontSize: 13)),
                        ),
                    ],
                  ),
                ),
                if (entry.answered) const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.check_circle, color: Colors.green, size: 20)),
              ],
            ),
          ),
        );
      },
    );
  }
}
