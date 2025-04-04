class RMessage {
  final String text;
  final bool isUser;
  final DateTime dateTime;

  const RMessage(
      {required this.text, required this.isUser, required this.dateTime});
}
