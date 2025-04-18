import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/rmodel.dart';
import '../utilities/utils.dart';

class RFetch extends ChangeNotifier {
  List<RMessage> rmessage = [];
  List<RMessage> get rmessages => rmessage;

  void addMessage(RMessage messages) {
    rmessage.add(messages);
    notifyListeners();
  }

  void deleteMessage(RMessage deletedMessage) async {
    rmessage.remove(deletedMessage);
    final userid = Supabase.instance.client.auth.currentUser;
    if (userid == null) return;
    await Supabase.instance.client
        .from('rmessages')
        .delete()
        .match({'user_id': userid.id, 'user_prompt': deletedMessage.text});
    notifyListeners();
  }

  Future<void> loadSupabaseRMessage() async {
    final user = Supabase.instance.client.auth.currentUser!;
    final data = await Supabase.instance.client
        .from('rmessages')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: true);
    print(data);
    List<RMessage> allRMessages = [];
    for (final row in data) {
      allRMessages.addAll(getRMessages(row));
    }
    rmessage = allRMessages;
  }

  Future<void> sendRMessage(String text) async {
    final userid = Supabase.instance.client.auth.currentUser?.id;
    if (userid == null) return;
    final insertedMessage = await Supabase.instance.client
        .from("rmessages")
        .insert({"user_id": userid, "isUser": true, "user_prompt": text})
        .select()
        .single();
    final messageId = insertedMessage['id'];
    final addedRMessage =
        RMessage(text: text, isUser: true, dateTime: DateTime.now().toString());
    addMessage(addedRMessage);

    final typingRMessage = RMessage(
        text: "Handiika ....",
        isUser: false,
        dateTime: DateTime.now().toString());
    addMessage(typingRMessage);

    try {
      final botResponse = await sendRRequest(text);

      rmessage.removeLast();
      addMessage(botResponse);
      await Supabase.instance.client
          .from('rmessages')
          .update({'response': botResponse.text}).eq('id', messageId);
    } catch (e) {
      rmessage.removeLast();
      addMessage(RMessage(
          text: "Error $e",
          isUser: false,
          dateTime: DateTime.now().toString()));
    }
  }

  Future<RMessage> sendRRequest(String userInput) async {
    final response = await http.post(Uri.parse("$baseUrl/$runyankoleEndpoint"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"prompt": userInput}));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);
      return RMessage(
          text: result["response"],
          isUser: false,
          dateTime: DateTime.now().toString());
    } else {
      throw Exception("Haine ekyashoba");
    }
  }
}
