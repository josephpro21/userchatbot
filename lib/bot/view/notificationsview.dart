import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/fetchNotifications.dart';
import '../utilities/utils.dart';

class UserNotificationView extends StatelessWidget {
  const UserNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.read<GetNotifications>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: notificationProvider.gettingNotification(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('${snapshot.error}'),
                      ));
                    }
                    return Consumer<GetNotifications>(
                        builder: (context, notProvider, child) {
                      final data = notProvider.notification;
                      if (data == null) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(paddingValue),
                            child: const Text("No Notifications at the moment"),
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.all(paddingValue),
                        child: ListTile(
                          // leading: const CircleAvatar(
                          //     child: Icon(Icons.notifications)),
                          title: Text(
                            data.title,
                            maxLines: null,
                          ),
                          subtitle: ListView(
                            children: [
                              Text(
                                data.description,
                                maxLines: null,
                              ),
                              Text(
                                data.date,
                                maxLines: null,
                              )
                            ],
                          ),
                          // trailing: Checkbox(
                          //     value: data.isSeen,
                          //     onChanged: (value) {
                          //       value = !data.isSeen;
                          //     })
                        ),
                      );
                    });
                  }))
        ],
      ),
    );
  }
}
