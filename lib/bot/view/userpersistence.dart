import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'initial.dart';
import 'login.dart';

class UserAuthChanges extends StatelessWidget {
  const UserAuthChanges({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: LinearProgressIndicator()));
          }
          final session = snapshot.hasData ? snapshot.data!.session : null;
          if (session != null) {
            return const Initial();
          } else {
            return const Login();
          }
        });
  }
}
