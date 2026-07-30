class FavoriteModel {
  final String id;
  final String prayerId;
  final DateTime createdAt;

  FavoriteModel({
    required this.id,
    required this.prayerId,
    required this.createdAt,
  });

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] ?? '',
      prayerId: map['prayerId'] ?? '',
      createdAt: DateTime.parse(
        map['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prayerId': prayerId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
