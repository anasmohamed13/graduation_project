// ignore_for_file: avoid_print, no_wildcard_variable_uses

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static const String routeName = 'chatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBodyChatPage(),
    );
  }

  buildBodyChatPage() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              CircleAvatar(
                backgroundColor: const Color(0xffeef5ff),
                radius: 30,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  color: const Color(0xff8aa1b5),
                ),
              ),
              const SizedBox(width: 70),
              Image.asset(
                AppAssets.doctorChat,
              ),
            ],
          ),
          const Text(
            'Dr. Sam denis',
            style: TextStyle(
                fontFamily: 'inter', fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 52,
          ),
          const BubbleSpecialThree(
            text: 'Good morning, how is my son doing today?',
            color: Color(0xFF1B97F3),
            tail: false,
            isSender: false,
            textStyle: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'inter'),
          ),
          const Spacer(
            flex: 22,
          ),
          messageBAR(context),
          const Spacer(),
        ],
      ),
    );
  }
}

messageBAR(BuildContext context) {
  return Container(
      height: MediaQuery.of(context).size.height * 0.073,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xffd5e4fa),
            Color(0xffd5e4fa),
            Color(0xffb7d9f9),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
          child: Icon(
            Icons.attach_file,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Type Here",
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 13),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue[300],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.mic,
              color: Colors.white,
            ),
            onPressed: () {
              //will write logic when click here
            },
          ),
        )
      ]));
}
