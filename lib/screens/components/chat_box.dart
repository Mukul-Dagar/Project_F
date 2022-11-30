import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class Basic extends StatefulWidget {
  const Basic({super.key});

  @override
  _BasicState createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  ChatUser user = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );

  late List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      createdAt: DateTime.now(),
      user: user,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Chat with group'),
      ),
      body: DashChat(
        currentUser: user,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });
        },
        messages: messages,
      ),
    );
  }
}