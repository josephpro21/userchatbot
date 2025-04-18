class RMessage {
  final String? id;
  final String text;
  final bool isUser;
  final String dateTime;

  const RMessage(
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

List<RMessage> getRMessages(Map<String, dynamic> json) {
  return [
    RMessage(
        text: json['user_prompt'], isUser: true, dateTime: json["created_at"]),
    RMessage(
        text: json['response'] ?? 'Bot typing',
        isUser: false,
        dateTime: json["created_at"])
  ];
}
