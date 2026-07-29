class PrayerRequest {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool answered;

  PrayerRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.answered = false,
  });

  PrayerRequest copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? answered,
  }) {
    return PrayerRequest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      answered: answered ?? this.answered,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'answered': answered,
    };
  }

  factory PrayerRequest.fromJson(Map<String, dynamic> json) {
    return PrayerRequest(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      answered: json['answered'] ?? false,
    );
  }
}
