import 'package:darsstore/screenshots/chat/components/chat_body.dart';
import 'package:darsstore/screenshots/home/components/home_body.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: HomeBody(), 
    );
  }
}
