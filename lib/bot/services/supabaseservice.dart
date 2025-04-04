import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';
import '../model/rmodel.dart';
import '../model/userModel.dart';

class AuthService {
  final SupabaseClient supabaseClient = Supabase.instance.client;

  Future<String?> signUpUser(
      String username, String password, String email) async {
    try {
      final response =
          await supabaseClient.auth.signUp(email: email, password: password);
      if (response.user != null) {
        await supabaseClient.from('users').insert(
            {'id': response.user?.id, 'username': username, "email": email});
        return 'Sign up operation Successful';
      } else {
        return "Sign up failed";
      }
    } catch (error) {
      //throw Exception(error);
      return error.toString();
    }
  }

  Future<String?> signInUser(String password, String email) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user != null) {
        return 'Sign in successful';
      } else {
        return 'Something went wrong during sign in';
      }
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
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

  Future<void> saveEnglishMessage(Message message) async {}
  Future<void> saveRunyankoleMessage(RMessage rmessage) async {}
}
