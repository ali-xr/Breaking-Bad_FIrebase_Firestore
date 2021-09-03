import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:darsstore/screenshots/home/components/home_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.black38,
        elevation: 0,
        title: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w700,
              ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                "Breaking Bad",
                textStyle: TextStyle(color: Colors.redAccent.shade700),
              ),
              WavyAnimatedText(
                "The Best TV Show",
                textStyle: TextStyle(color: Colors.redAccent.shade700),
              ),
            ],
            isRepeatingAnimation: true,
            onTap: () {},
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bars,
                color: Colors.redAccent.shade700,
              ))
        ],
      ),
      body: HomeBody(),
    );
  }
}
