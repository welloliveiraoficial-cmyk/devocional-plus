class LocalBibleVerse {
  final int number;
  final String text;

  const LocalBibleVerse({
    required this.number,
    required this.text,
  });
}

class LocalBibleChapter {
  final String book;
  final String abbrev;
  final int chapter;
  final List<LocalBibleVerse> verses;

  const LocalBibleChapter({
    required this.book,
    required this.abbrev,
    required this.chapter,
    required this.verses,
  });
}

const List<LocalBibleChapter> localBible = [
  LocalBibleChapter(
    book: 'João',
    abbrev: 'jo',
    chapter: 1,
    verses: [
      LocalBibleVerse(
        number: 1,
        text: 'No princípio era o Verbo, e o Verbo estava com Deus, e o Verbo era Deus.',
      ),
      LocalBibleVerse(
        number: 2,
        text: 'Ele estava no princípio com Deus.',
      ),
      LocalBibleVerse(
        number: 3,
        text: 'Todas as coisas foram feitas por intermédio dele, e sem ele nada do que foi feito se fez.',
      ),
    ],
  ),
  LocalBibleChapter(
    book: 'Salmos',
    abbrev: 'sl',
    chapter: 23,
    verses: [
      LocalBibleVerse(
        number: 1,
        text: 'O Senhor é o meu pastor; nada me faltará.',
      ),
      LocalBibleVerse(
        number: 2,
        text: 'Deitar-me faz em verdes pastos, guia-me mansamente a águas tranquilas.',
      ),
      LocalBibleVerse(
        number: 3,
        text: 'Refrigera a minha alma; guia-me pelas veredas da justiça por amor do seu nome.',
      ),
    ],
  ),
];
