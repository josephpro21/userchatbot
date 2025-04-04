import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/model.dart';
import '../utilities/utils.dart';

class Fetch extends ChangeNotifier {
  List<Message> message = [];
  List<Message> get messages => message;

  void addMessage(Message messages) {
    message.add(messages);
    notifyListeners();
  }

  void deleteMessage(Message deletedMessage) {
    message.remove(deletedMessage);
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    final addedMessage =
        Message(text: text, isUser: true, dateTime: DateTime.now());
    addMessage(addedMessage);

    final typingMessage =
        Message(text: "Typing ....", isUser: false, dateTime: DateTime.now());
    addMessage(typingMessage);

    try {
      final botResponse = await sendRequest(text);

      message.removeLast();
      addMessage(botResponse);
    } catch (e) {
      message.removeLast();
      addMessage(
          Message(text: "Error $e", isUser: false, dateTime: DateTime.now()));
    }
  }

  Future<Message> sendRequest(String userInput) async {
    final response = await http.post(
        Uri.parse("$baseUrl/$englishChatBotEndpoint"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"prompt": userInput}));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);
      return Message(
          text: result["response"], isUser: false, dateTime: DateTime.now());
    } else {
      throw Exception("Something went wrong, please try again");
    }
  }
}
