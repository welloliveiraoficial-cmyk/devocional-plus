import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../data/bible_local_data.dart';

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

  BibleVerse({
    required this.number,
    required this.text,
  });

  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(
      number: json['number'],
      text: json['text'],
    );
  }
}

class BibleService {
  static const String _baseUrl = 'https://www.abibliadigital.com.br/api';
  static const String _version = 'nvi';

  static Future<List<BibleBook>> getBooks() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/books'))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final list = jsonDecode(response.body) as List;

        final books = list.map((e) => BibleBook.fromJson(e)).toList();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('bible_books_list', response.body);

        return books;
      }
    } catch (_) {}

    return _getLocalBooks();
  }

  static Future<List<BibleVerse>> getChapter(
      String bookAbbrev, int chapter) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              '$_baseUrl/verses/$_version/$bookAbbrev/$chapter',
            ),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final verses = data['verses'] as List;

        return verses.map((e) => BibleVerse.fromJson(e)).toList();
      }
    } catch (_) {}

    return _getLocalChapter(bookAbbrev, chapter);
  }

  static List<BibleBook> _getLocalBooks() {
    return localBible.map((item) {
      return BibleBook(
        abbrev: item.abbrev,
        name: item.book,
        testament: item.book == 'João' ? 'NT' : 'VT',
        chapters: 1,
      );
    }).toList();
  }

  static List<BibleVerse> _getLocalChapter(
      String abbrev, int chapter) {
    final result = localBible.where(
      (item) =>
          item.abbrev == abbrev &&
          item.chapter == chapter,
    );

    if (result.isEmpty) {
      throw Exception('Capítulo não disponível offline.');
    }

    return result.first.verses
        .map(
          (verse) => BibleVerse(
            number: verse.number,
            text: verse.text,
          ),
        )
        .toList();
  }
}
