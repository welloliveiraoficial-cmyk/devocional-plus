class PrayerService {
  const PrayerService();

  Future<List<Map<String, String>>> getDailyPrayers() async {
    return [
      {
        "title": "Oração da Manhã",
        "content":
            "Senhor, obrigado por este novo dia. Guia meus passos, fortalece minha fé e enche meu coração com a tua paz. Amém."
      },
      {
        "title": "Oração da Tarde",
        "content":
            "Pai amado, permanece comigo durante este dia. Dá-me sabedoria, proteção e confiança para vencer cada desafio. Amém."
      },
      {
        "title": "Oração da Noite",
        "content":
            "Deus, obrigado por cuidar de mim durante este dia. Entrego minha vida em tuas mãos e descanso na tua presença. Amém."
      }
    ];
  }
}
