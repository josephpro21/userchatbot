import 'package:flutter/material.dart';
import 'package:mama/bot/services/supabaseservice.dart';
import 'package:mama/bot/view/runyankoleui.dart';
import 'package:mama/bot/view/ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utilities/button.dart';
import '../utilities/utils.dart';
import 'notificationsview.dart';

class Initial extends StatefulWidget {
  const Initial({super.key});

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final client = Supabase.instance.client;

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
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                      client.auth.currentUser!.email?[0].toUpperCase() ??
                          'email',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  accountName: FutureBuilder(
                      future: authService.getUsername(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('..');
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return Text('${snapshot.data}');
                      }),
                  accountEmail: client.auth.currentUser != null
                      ? Text(client.auth.currentUser?.email ?? 'E')
                      : Text('User')),
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
              ListTile(
                leading: const Text(
                  'Contact us',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  showModalBottomSheet(
                      showDragHandle: true,
                      useSafeArea: true,
                      elevation: 10,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              ListTile(
                                leading: Icon(Icons.email),
                                title: Text('email'),
                                subtitle: Text('mamauganda@gmail.com'),
                              ),
                              ListTile(
                                leading: Icon(Icons.call),
                                title: Text('phone number'),
                                subtitle: Text("0766496691"),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
              ListTile(
                leading: Text(
                  'Update User Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  showModalBottomSheet(
                      showDragHandle: true,
                      useSafeArea: true,
                      elevation: 10,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 18,
                            children: [
                              Text(
                                'Update User Profile',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter username',
                                  labelText: 'Enter username',
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                              ButtonWidget(
                                  onPressed: () async {
                                    if (usernameController.text.isNotEmpty) {
                                      authService.updateUserDetails(context,
                                          usernameController.text.toString());
                                          usernameController.clear();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'username must not be empty')));
                                    }
                                  },
                                  text: 'Update'),
                            ],
                          ),
                        );
                      });
                },
              ),
              ListTile(
                leading: const Text(
                  'About Developer',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  showModalBottomSheet(
                      showDragHandle: true,
                      useSafeArea: true,
                      elevation: 10,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Developer Detail',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ListTile(
                                leading:
                                    CircleAvatar(child: Icon(Icons.person)),
                                title: Text('Ainembabazi Damaly'),
                                subtitle: Text('Eng'),
                              ),
                              ListTile(
                                leading:
                                    CircleAvatar(child: Icon(Icons.person)),
                                title: Text('Tukasiima Blessing'),
                                subtitle: Text('Eng'),
                              ),
                              ListTile(
                                leading:
                                    CircleAvatar(child: Icon(Icons.person)),
                                title: Text('Iga Martin'),
                                subtitle: Text('Eng'),
                              ),
                              ListTile(
                                leading:
                                    CircleAvatar(child: Icon(Icons.person)),
                                title: Text('Bbira Victor Kevin'),
                                subtitle: Text('Eng'),
                              ),
                            ],
                          ),
                        );
                      });
                },
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
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Welcome! Chat With $appName a chatbot designed to help with all inquires concerning your pregnancy',
            maxLines: null,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
