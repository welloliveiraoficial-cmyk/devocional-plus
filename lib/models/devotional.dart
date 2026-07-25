class Devotional {
  final String id;
  final String title;
  final String theme;
  final String verseText;
  final String verseRef;
  final String reflection;
  final String application;
  final String prayer;
  final int readingMinutes;

  const Devotional({
    required this.id,
    required this.title,
    required this.theme,
    required this.verseText,
    required this.verseRef,
    required this.reflection,
    required this.application,
    required this.prayer,
    required this.readingMinutes,
  });
}
