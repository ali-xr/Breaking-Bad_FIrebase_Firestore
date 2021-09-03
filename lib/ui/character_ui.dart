import 'package:flutter/material.dart';

// 2 - Step pubspec.yaml ga http package
// 3 - Step API characteri uchun ui
class CharacterUI extends StatelessWidget {
  const CharacterUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Breaking Bad"),
      ),
    );
  }
}