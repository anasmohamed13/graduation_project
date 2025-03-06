import 'package:flutter/material.dart';

class AiChat extends StatelessWidget {
  static const String routeName = 'Aichat';
  const AiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbarAiChat(),
    );
  }

  AppBar buildAppbarAiChat() {
    // update this code to write row and in this row column to make same design
    return AppBar(
      elevation: 0,
      leadingWidth: 100,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(6.0),
        child: CircleAvatar(
          backgroundColor: const Color(0xffeef5ff),
          radius: 20,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            color: const Color(0xff8aa1b5),
          ),
        ),
      ),
      centerTitle: true,
      title: const Text(
        'My Profile',
        style: TextStyle(
            fontFamily: 'inter', fontSize: 28, fontWeight: FontWeight.w600),
      ),
    );
  }
}
