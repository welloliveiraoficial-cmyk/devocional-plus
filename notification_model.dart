class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime scheduledAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.scheduledAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      scheduledAt: DateTime.parse(
        map['scheduledAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'scheduledAt': scheduledAt.toIso8601String(),
    };
  }
}
