import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';
import '../model/rmodel.dart';
import '../model/userModel.dart';

class AuthService {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  Future<String?> signUpUser(BuildContext context, String username,
      String password, String email) async {
    try {
      final response =
          await supabaseClient.auth.signUp(email: email, password: password);
      final user = response.user;
      if (user != null) {
        await supabaseClient
            .from('userprofile')
            .insert({"user_id": user.id, 'username': username, "email": email});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sign up successful'),
          elevation: 9,
          margin: EdgeInsets.all(9),
          padding: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sign up failed'),
          elevation: 9,
          margin: EdgeInsets.all(9),
          padding: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: Colors.red,
        ));
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        elevation: 9,
        margin: EdgeInsets.all(9),
        padding: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString(), maxLines: null),
        elevation: 9,
        margin: EdgeInsets.all(9),
        padding: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.red,
      ));
    }
    return null;
  }

  Future<String?> signInUser(
      BuildContext context, String password, String email) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successful'),
          elevation: 9,
          margin: EdgeInsets.all(9),
          padding: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login failed'),
          elevation: 9,
          margin: EdgeInsets.all(9),
          padding: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: Colors.red,
        ));
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        elevation: 9,
        margin: EdgeInsets.all(9),
        padding: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.red,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString(), maxLines: null),
        elevation: 9,
        margin: EdgeInsets.all(9),
        padding: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.red,
      ));
    }
    return null;
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  Future<String?> getUsername() async {
    final user = Supabase.instance.client.auth.currentUser;
    final response = await supabaseClient
        .from('userprofile')
        .select('username')
        .eq('user_id', supabaseClient.auth.currentUser!.id)
        .single();
    if (user == null) return null;

    if (response['username'] != null) {
      return response['username'] as String;
    }
    return null;
  }

  Future<Object> getCurrentUserDetails() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      return 'null';
    } else {
      return UserModel(
          id: user.id,
          username: user.userMetadata?['username'],
          email: user.email ?? '',
          lastSignIn: user.lastSignInAt ?? '',
          createdAt: user.createdAt);
    }
  }

  Future<void> updateUserDetails(BuildContext context, String? username) async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user != null) return;
      final response = await supabaseClient
          .from('userprofile')
          .update({"username": username}).eq("user_id", user!.id);
      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Update success'),
          elevation: 9,
          margin: EdgeInsets.all(9),
          padding: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error occurred while updating'),
          elevation: 9,
          margin: EdgeInsets.all(9),
          padding: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          closeIconColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString(), maxLines: null),
        elevation: 9,
        margin: EdgeInsets.all(9),
        padding: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.red,
      ));
    }
  }

  Future<void> saveEnglishMessage(Message message) async {}
  Future<void> saveRunyankoleMessage(RMessage rmessage) async {}
}
