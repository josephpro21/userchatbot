import 'package:flutter/material.dart';
import 'package:mama/bot/services/supabaseservice.dart';
import 'package:mama/bot/view/runyankoleui.dart';
import 'package:mama/bot/view/ui.dart';

import '../utilities/utils.dart';
import 'notificationsview.dart';

class Initial extends StatelessWidget {
  const Initial({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 181, 206, 1),
      appBar: AppBar(
        title: Text(
          appName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              child: const Icon(
                Icons.notification_add_rounded,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserNotificationView()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const ListTile(
                leading: Text(
                  'Model Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const ListTile(
                leading: Text(
                  'Contact us',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const ListTile(
                leading: Text(
                  'Report Issue',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const ListTile(
                leading: Text(
                  'About Developer',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const ListTile(
                leading: Text(
                  'App Version',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                trailing: Text('0.01'),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      onPressed: () {
                        authService.signOut();
                      },
                      icon: const Icon(Icons.logout)),
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 90,
            backgroundImage: AssetImage('assets/images/botlogo.jpg'),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Chat | Ngambira',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 24),
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: Colors.blue, width: 2))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen()));
                    },
                    child: const Text(
                      'English',
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 24),
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: Colors.blue, width: 2))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RChatScreen()));
                    },
                    child: const Text(
                      'Runyankole',
                    ))
              ],
            ),
          )
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Welcome! Chat With $appName a chatbot designed to help with all inquires concerning your pregnancy',
            maxLines: null,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
