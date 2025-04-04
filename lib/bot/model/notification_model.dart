class UserNotification {
  final String title;
  final String description;
  final bool isSeen;
  final String date;

  const UserNotification(
      {required this.title,
      required this.description,
      required this.isSeen,
      required this.date});

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      UserNotification(
          title: json['title'],
          description: json['description'],
          isSeen: json['isSeen'] ?? false,
          date: json['date']);
}
