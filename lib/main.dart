import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:mama/bot/view/userpersistence.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'bot/services/fetch.dart';
import 'bot/services/fetchNotifications.dart';
import 'bot/services/rfetch.dart';
import 'bot/utilities/utils.dart';
import 'bot/view/notificationsview.dart';
import 'bot/view/runyankoleui.dart';
import 'bot/view/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => Fetch(),
        child: ChatScreen(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => GetNotifications(),
        child: const UserNotificationView(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => RFetch(),
        child: RChatScreen(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (light, dark) {
      const useMaterial3 = true;
      const seedColor = Colors.lightGreen;
      const secondary = Colors.cyan;
      return MaterialApp(
        theme: ThemeData(
          colorScheme: light ??
              ColorScheme.fromSeed(seedColor: seedColor, secondary: secondary),
          useMaterial3: useMaterial3,
        ),
        darkTheme: ThemeData(
          colorScheme: dark ??
              ColorScheme.fromSeed(
                  seedColor: seedColor,
                  secondary: secondary,
                  brightness: Brightness.dark),
          useMaterial3: useMaterial3,
        ),
        home: const UserAuthChanges(),
      );
    });
  }
}
