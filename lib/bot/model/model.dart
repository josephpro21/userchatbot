class Message {
  final String text;
  final bool isUser;
  final DateTime dateTime;

  const Message(
      {required this.text, required this.isUser, required this.dateTime});
}
