import 'package:flutter/material.dart';
import 'package:mama/bot/utilities/utils.dart';
import 'package:provider/provider.dart';

import '../services/rfetch.dart';

class RChatScreen extends StatelessWidget {
  RChatScreen({super.key});
  final wordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gamba na $appName"),
        ),
        body: Column(
          children: [
            _buildingChatList(context),
            _buildingMessageInput(context)
          ],
        ));
  }

  Widget _buildingChatList(BuildContext context) {
    return Consumer<RFetch>(builder: (context, foundData, child) {
      return Expanded(
          child: foundData.rmessages.isEmpty
              ? const Center(
                  child: Text(
                    'Tandika ekiganiro',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                )
              : FutureBuilder(
                  future: foundData.loadSupabaseRMessage(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${snapshot.error}', maxLines: null),
                        ),
                      );
                    }
                    return ListView.builder(
                        reverse: true,
                        itemCount: foundData.rmessages.length,
                        itemBuilder: (context, index) {
                          final data = foundData.rmessages[
                              foundData.rmessages.length - 1 - index];
                          return Align(
                            alignment: data.isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card.outlined(
                                color: data.isUser
                                    ? Colors.pinkAccent
                                    : Colors.grey[500],
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: ListTile(
                                    leading: Icon(
                                      data.isUser
                                          ? Icons.person
                                          : Icons.smart_toy,
                                      color: data.isUser
                                          ? Colors.greenAccent
                                          : Colors.purple,
                                    ),
                                    title: SelectableText(
                                      data.text,
                                    ),
                                    subtitle: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        '${DateTime.parse(data.dateTime).hour + 3}: ${DateTime.parse(data.dateTime).minute}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                icon: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                title: const Text(
                                                    'Sangura mesege'),
                                                titlePadding:
                                                    const EdgeInsets.all(10),
                                                content: const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 50.0),
                                                  child: Text('Nochihamia ?'),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(14),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                          "Shazamu")),
                                                  TextButton(
                                                    onPressed: () {
                                                      Provider.of<RFetch>(
                                                              context,
                                                              listen: false)
                                                          .deleteMessage(data);
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            'Deletion Success'),
                                                        elevation: 9,
                                                        margin:
                                                            EdgeInsets.all(9),
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        showCloseIcon: true,
                                                        closeIconColor:
                                                            Colors.red,
                                                      ));
                                                    },
                                                    child: const Text(
                                                      "Sangura",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ));
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }));
    });
  }

  Widget _buildingMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            maxLines: null,
            controller: wordController,
            decoration: const InputDecoration(
                hintText: 'Handika messege',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
          )),
          IconButton(
              onPressed: () {
                final text = wordController.text.trim();
                if (text.isNotEmpty) {
                  Provider.of<RFetch>(context, listen: false)
                      .sendRMessage(text);
                  wordController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Handika messege'),
                    elevation: 9,
                    margin: EdgeInsets.all(9),
                    padding: EdgeInsets.all(10),
                    behavior: SnackBarBehavior.floating,
                    showCloseIcon: true,
                    closeIconColor: Colors.red,
                  ));
                }
              },
              icon: const CircleAvatar(
                radius: 25,
                child: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ))
        ],
      ),
    );
  }
}
