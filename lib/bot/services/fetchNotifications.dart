import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/notification_model.dart';
import '../utilities/utils.dart';

class GetNotifications extends ChangeNotifier {
  UserNotification? notification;
  UserNotification? get notifications => notification;

  Future<void> gettingNotification() async {
    final response = await http.get(
        Uri.parse("$baseUrl/$notificationsEndpoint"),
        headers: {'Content-Type': "application/json"});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      notification = UserNotification.fromJson(data);
      notifyListeners();
    } else {
      throw Exception('Error occurred getting notifications');
    }
  }
}
