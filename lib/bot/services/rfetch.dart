import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/rmodel.dart';
import '../utilities/utils.dart';

class RFetch extends ChangeNotifier {
  List<RMessage> rmessage = [];
  List<RMessage> get rmessages => rmessage;

  void addMessage(RMessage messages) {
    rmessage.add(messages);
    notifyListeners();
  }

  void deleteMessage(RMessage deletedMessage) {
    rmessage.remove(deletedMessage);
    notifyListeners();
  }

  Future<void> sendRMessage(String text) async {
    final addedRMessage =
        RMessage(text: text, isUser: true, dateTime: DateTime.now());
    addMessage(addedRMessage);

    final typingRMessage = RMessage(
        text: "Handiika ....", isUser: false, dateTime: DateTime.now());
    addMessage(typingRMessage);

    try {
      final botResponse = await sendRRequest(text);

      rmessage.removeLast();
      addMessage(botResponse);
    } catch (e) {
      rmessage.removeLast();
      addMessage(
          RMessage(text: "Error $e", isUser: false, dateTime: DateTime.now()));
    }
  }

  Future<RMessage> sendRRequest(String userInput) async {
    final response = await http.post(Uri.parse("$baseUrl/$runyankoleEndpoint"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"prompt": userInput}));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      debugPrint(result);
      return RMessage(
          text: result["response"], isUser: false, dateTime: DateTime.now());
    } else {
      throw Exception("Haine ekyashoba");
    }
  }
}
