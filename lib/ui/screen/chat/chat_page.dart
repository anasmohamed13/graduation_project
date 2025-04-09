// ignore_for_file: avoid_print, no_wildcard_variable_uses

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  final bool isDoctor;

  const ChatPage({super.key, this.isDoctor = false});
  static const String routeName = 'chatPage';
  static bool isTyping = false;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late bool isDoctor;

  @override
  void initState() {
    super.initState();
    isDoctor = widget.isDoctor;
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) {
      return;
    }
    String messageText = messageController.text.trim();
    // String senderId = auth.currentUser?.uid ?? 'anonymous';
    String senderType = isDoctor ? 'doctor' : 'parent';

    firestore.collection('messages').add({
      'text': messageText,
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'sent',
      'senderType': senderType,
    });

    messageController.clear();
    setState(() => ChatPage.isTyping = false);
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments != null && arguments.containsKey('isDoctor')) {
      isDoctor = arguments['isDoctor'];
    }

    return Scaffold(
      body: buildBodyChatPage(),
    );
  }

  SafeArea buildBodyChatPage() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 20),
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
              Image.asset(AppAssets.doctorChat),
            ],
          ),
          Text(
            isDoctor ? 'Patient Conversation' : 'Dr. Sam denis',
            style: const TextStyle(
                fontFamily: 'inter', fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 52),
          StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('messages')
                .orderBy('timestamp', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              List<QueryDocumentSnapshot<Object?>> messages =
                  snapshot.data!.docs;
              return SizedBox(
                height: 470,
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot<Object?> message = messages[index];

                    String senderType = 'parent';
                    try {
                      Map<String, dynamic> data =
                          message.data() as Map<String, dynamic>;
                      if (data.containsKey('senderType')) {
                        senderType = data['senderType'];
                      }
                    } catch (e) {
                      print('Error accessing senderType: $e');
                    }

                    bool isSender = (senderType == 'doctor' && isDoctor) ||
                        (senderType == 'parent' && !isDoctor);

                    return BubbleSpecialThree(
                      text: message['text'],
                      color: isSender
                          ? const Color(0xFF8fb2eb)
                          : const Color(0xFFE8E8EE),
                      tail: true,
                      isSender: isSender,
                      textStyle: TextStyle(
                          color: isSender
                              ? const Color(0xff55688b)
                              : Colors.black87,
                          fontSize: 20,
                          fontFamily: 'inter'),
                    );
                  },
                ),
              );
            },
          ),
          const Spacer(
            flex: 10,
          ),
          messageBAR(context, messageController, (bool typing) {
            setState(() => ChatPage.isTyping = typing);
          }, ChatPage.isTyping),
          const Spacer(),
        ],
      ),
    );
  }

  Container messageBAR(BuildContext context, TextEditingController controller,
      Function(bool) onTyping, bool isTyping) {
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
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 20),
            child: Icon(
              Icons.attach_file,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: isDoctor ? "Reply to patient..." : "Type Here",
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
              onChanged: (text) {
                onTyping(text.trim().isNotEmpty);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 13),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[300],
            ),
            child: IconButton(
              icon: Icon(
                isTyping ? Icons.send : Icons.mic,
                color: Colors.white,
              ),
              onPressed: () {
                if (isTyping) {
                  sendMessage();
                } else {
                  // will add Voice message functionality
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
