import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/fetch.dart';
import '../utilities/utils.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat With $appName",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Column(
          children: [_buildChatList(context), _buildMessageInput(context)],
        ));
  }

  Widget _buildChatList(BuildContext context) {
    return Consumer<Fetch>(builder: (context, items, child) {
      return Expanded(
        child: items.messages.isEmpty
            ? const Center(
                child: Text(
                  'Start Conversation',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            : ListView.builder(
                reverse: true,
                itemCount: items.messages.length,
                itemBuilder: (context, index) {
                  final data =
                      items.messages[items.messages.length - 1 - index];
                  return Align(
                    alignment: data.isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card.outlined(
                        color:
                            data.isUser ? Colors.pinkAccent : Colors.grey[500],
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: ListTile(
                            leading: Icon(
                              data.isUser ? Icons.person : Icons.smart_toy,
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
                                '${data.dateTime.hour}: ${data.dateTime.minute}',
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
                                        title: const Text('Delete Message'),
                                        titlePadding: const EdgeInsets.all(10),
                                        content: const Padding(
                                          padding: EdgeInsets.only(left: 50.0),
                                          child: Text('Are you sure ?'),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(14),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                            onPressed: () {
                                              Provider.of<Fetch>(context,
                                                      listen: false)
                                                  .deleteMessage(data);
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Deletion Success'),
                                                elevation: 9,
                                                margin: EdgeInsets.all(9),
                                                padding: EdgeInsets.all(10),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                showCloseIcon: true,
                                                closeIconColor: Colors.red,
                                              ));
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
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
                }),
      );
    });
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            maxLines: null,
            controller: _controller,
            decoration: const InputDecoration(
                hintText: 'Type message',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
          )),
          IconButton(
              onPressed: () {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  Provider.of<Fetch>(context, listen: false).sendMessage(text);
                  _controller.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Type a message'),
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
                  semanticLabel: 'Send Message',
                  Icons.send,
                  color: Colors.blue,
                ),
              ))
        ],
      ),
    );
  }
}
