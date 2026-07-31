class PrayerEntry {
  final String id;
  final String title;
  final String description;
  final String category; // 'Pedido', 'Agradecimento' ou 'Testemunho'
  final DateTime createdAt;
  final bool answered;
  final bool favorite;

  const PrayerEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    this.answered = false,
    this.favorite = false,
  });

  PrayerEntry copyWith({
    String? title,
    String? description,
    String? category,
    bool? answered,
    bool? favorite,
  }) {
    return PrayerEntry(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      createdAt: createdAt,
      answered: answered ?? this.answered,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'createdAt': createdAt.toIso8601String(),
        'answered': answered,
        'favorite': favorite,
      };

  factory PrayerEntry.fromJson(Map<String, dynamic> json) {
    return PrayerEntry(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']),
      answered: json['answered'] ?? false,
      favorite: json['favorite'] ?? false,
    );
  }
}
