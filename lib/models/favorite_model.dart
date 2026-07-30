class FavoriteModel {
  final String id;
  final String devotionalId;
  final DateTime createdAt;

  const FavoriteModel({
    required this.id,
    required this.devotionalId,
    required this.createdAt,
  });

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] ?? '',
      devotionalId: map['devotionalId'] ?? '',
      createdAt: DateTime.parse(
        map['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'devotionalId': devotionalId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  FavoriteModel copyWith({
    String? id,
    String? devotionalId,
    DateTime? createdAt,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      devotionalId: devotionalId ?? this.devotionalId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
