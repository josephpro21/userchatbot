import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';
import '../utilities/utils.dart';

class Fetch extends ChangeNotifier {
  List<Message> message = [];
  List<Message> get messages => message;

  Future<void> loadSupabaseSMessage() async {
    final user = Supabase.instance.client.auth.currentUser!;
    final data = await Supabase.instance.client
        .from('messages')
        .select()
        .eq('user_id', user.id)
        .order(ascending: true, 'created_at');
    print(data);
    List<Message> allMessages = [];
    for (final row in data) {
      allMessages.addAll(messagesfromSupabse(row));
    }
    message = allMessages;
    //notifyListeners();
    //print(message);
  }

  void addMessage(Message messages) {
    message.add(messages);

    notifyListeners();
  }

  void deleteMessage(Message deletedMessage) async {
    message.remove(deletedMessage);
    final userid = Supabase.instance.client.auth.currentUser;
    if (userid == null) return;
    await Supabase.instance.client
        .from('messages')
        .delete()
        .match({'user_id': userid.id, 'user_prompt': deletedMessage.text});

    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    final userid = Supabase.instance.client.auth.currentUser?.id;
    if (userid == null) return;
    final insertMessage = await Supabase.instance.client
        .from('messages')
        .insert({"user_id": userid, "user_prompt": text, "isUser": true})
        .select()
        .single();
    final messageId = insertMessage["id"];

    final addedMessage =
        Message(text: text, isUser: true, dateTime: DateTime.now().toString());
    addMessage(addedMessage);

    final typingMessage = Message(
        text: "Typing ....",
        isUser: false,
        dateTime: DateTime.now().toString());
    addMessage(typingMessage);

    try {
      final botResponse = await sendRequest(text);

      message.removeLast();
      addMessage(botResponse);
      await Supabase.instance.client
          .from('messages')
          .update({'response': botResponse.text}).eq('id', messageId);
    } catch (e) {
      message.removeLast();
      addMessage(Message(
          text: "Error $e",
          isUser: false,
          dateTime: DateTime.now().toString()));
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
          text: result["response"],
          isUser: false,
          dateTime: DateTime.now().toString());
    } else {
      throw Exception("Something went wrong, please try again");
    }
  }
}
