import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prayer_entry.dart';

class PrayerService {
  static const _key = 'prayer_entries';

  static Future<List<PrayerEntry>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    final entries = list.map((e) => PrayerEntry.fromJson(e)).toList();
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries;
  }

  static Future<void> _saveAll(List<PrayerEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(entries.map((e) => e.toJson()).toList());
    await prefs.setString(_key, raw);
  }

  static Future<void> add(PrayerEntry entry) async {
    final entries = await getAll();
    entries.add(entry);
    await _saveAll(entries);
  }

  static Future<void> update(PrayerEntry entry) async {
    final entries = await getAll();
    final index = entries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      entries[index] = entry;
      await _saveAll(entries);
    }
  }

  static Future<void> delete(String id) async {
    final entries = await getAll();
    entries.removeWhere((e) => e.id == id);
    await _saveAll(entries);
  }
}
