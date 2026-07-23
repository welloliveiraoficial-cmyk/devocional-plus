import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BibleBook {
  final String abbrev;
  final String name;
  final String testament;
  final int chapters;

  BibleBook({
    required this.abbrev,
    required this.name,
    required this.testament,
    required this.chapters,
  });

  factory BibleBook.fromJson(Map<String, dynamic> json) {
    return BibleBook(
      abbrev: json['abbrev']['pt'],
      name: json['name'],
      testament: json['testament'],
      chapters: json['chapters'],
    );
  }
}

class BibleVerse {
  final int number;
  final String text;
  BibleVerse({required this.number, required this.text});

  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(number: json['number'], text: json['text']);
  }
}

class BibleService {
  static const String _baseUrl = 'https://www.abibliadigital.com.br/api';
  static const String _version = 'nvi';

  static Future<List<BibleBook>> getBooks() async {
    final prefs = await SharedPreferences.getInstance();
    const cacheKey = 'bible_books_list';
    final cached = prefs.getString(cacheKey);
    if (cached != null) {
      final list = jsonDecode(cached) as List;
      return list.map((e) => BibleBook.fromJson(e)).toList();
    }
    final response = await http.get(Uri.parse('$_baseUrl/books'));
    if (response.statusCode != 200) {
      throw Exception('Não foi possível carregar os livros da Bíblia.');
    }
    await prefs.setString(cacheKey, response.body);
    final list = jsonDecode(response.body) as List;
    return list.map((e) => BibleBook.fromJson(e)).toList();
  }

  static Future<List<BibleVerse>> getChapter(String bookAbbrev, int chapter) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'bible_${_version}_${bookAbbrev}_$chapter';
    final cached = prefs.getString(cacheKey);
    if (cached != null) {
      final list = jsonDecode(cached) as List;
      return list.map((e) => BibleVerse.fromJson(e)).toList();
    }
    final response = await http.get(Uri.parse('$_baseUrl/verses/$_version/$bookAbbrev/$chapter'));
    if (response.statusCode != 200) {
      throw Exception('Não foi possível carregar este capítulo.');
    }
    final data = jsonDecode(response.body);
    final verses = data['verses'] as List;
    await prefs.setString(cacheKey, jsonEncode(verses));
    return verses.map((e) => BibleVerse.fromJson(e)).toList();
  }
}
