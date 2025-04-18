class Message {
  final String? id;
  final String text;
  final bool isUser;
  final String dateTime;

  const Message(
      {this.id,
      required this.text,
      required this.isUser,
      required this.dateTime});
  Map<String, dynamic> toMap(String userId) => {
        "user_id": userId,
        "isUser": isUser,
        "user_prompt": isUser ? text : null,
        "response": !isUser ? text : null
      };
}

List<Message> messagesfromSupabse(Map<String, dynamic> json) {
  return [
    Message(
        text: json['user_prompt'], isUser: true, dateTime: json["created_at"]),
    Message(
        text: json['response'] ?? 'Bot thinking',
        isUser: false,
        dateTime: json["created_at"])
  ];
}
