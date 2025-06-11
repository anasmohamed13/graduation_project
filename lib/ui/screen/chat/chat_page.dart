// ignore_for_file: avoid_print

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/util/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  final String? doctorEmail;
  final String? parentEmail;

  const ChatPage({
    super.key,
    this.doctorEmail,
    this.parentEmail,
  });

  static const String routeName = 'chatPage';
  static bool isTyping = false;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? otherUserName;
  String? otherUserImage;
  bool isLoadingOtherUser = true;
  String? doctorEmail;
  String? parentEmail;

  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _initializeEmails();
  }

  void _initializeEmails() {
    // إذا تم تمرير البيانات عبر Constructor
    if (widget.doctorEmail != null && widget.parentEmail != null) {
      doctorEmail = widget.doctorEmail;
      parentEmail = widget.parentEmail;
      fetchOtherUserData();
    } else {
      // إذا تم تمرير البيانات عبر arguments
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        if (args != null) {
          setState(() {
            doctorEmail = args['doctorEmail'];
            parentEmail = args['parentEmail'];
          });
          fetchOtherUserData();
        }
      });
    }
  }

  void fetchOtherUserData() async {
    if (doctorEmail == null || parentEmail == null) return;

    bool isDoctor = auth.currentUser!.email == doctorEmail;
    String otherUserEmail = isDoctor ? parentEmail! : doctorEmail!;
    String collection = isDoctor ? 'Parent' : 'Doctor';

    try {
      final doc =
          await firestore.collection(collection).doc(otherUserEmail).get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          otherUserName = data['fullName'] ?? 'User';
          otherUserImage = data['profileImage'];
          isLoadingOtherUser = false;
        });
      } else {
        setState(() => isLoadingOtherUser = false);
      }
    } catch (e) {
      print('Error fetching other user data: $e');
      setState(() => isLoadingOtherUser = false);
    }
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty ||
        doctorEmail == null ||
        parentEmail == null) return;

    String messageText = messageController.text.trim();
    String senderType =
        auth.currentUser!.email == doctorEmail ? 'Doctor' : 'Parent';

    firestore
        .collection('chats')
        .doc('${doctorEmail}_${parentEmail}')
        .collection('messages')
        .add({
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
    return Scaffold(
      body: buildBodyChatPage(),
    );
  }

  SafeArea buildBodyChatPage() {
    if (doctorEmail == null || parentEmail == null) {
      return const SafeArea(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    bool isDoctor = auth.currentUser!.email == doctorEmail;

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
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  color: const Color(0xff8aa1b5),
                ),
              ),
              const SizedBox(width: 70),
              Image.asset(AppAssets.doctorChat),
            ],
          ),
          const SizedBox(height: 10),
          isLoadingOtherUser
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    if (otherUserImage != null && otherUserImage!.isNotEmpty)
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(otherUserImage!),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      otherUserName ?? 'User',
                      style: const TextStyle(
                        fontFamily: 'inter',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('chats')
                .doc('${doctorEmail}_${parentEmail}')
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
                    var message = messages[index];
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

                    bool isSender = (senderType == 'Doctor' && isDoctor) ||
                        (senderType == 'Parent' && !isDoctor);

                    return BubbleSpecialThree(
                      text: message['text'],
                      color: isSender
                          ? const Color(0xFF8fb2eb)
                          : const Color(0xFFE8E8EE),
                      tail: true,
                      isSender: isSender,
                      textStyle: TextStyle(
                        color:
                            isSender ? const Color(0xff55688b) : Colors.black87,
                        fontSize: 20,
                        fontFamily: 'inter',
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const Spacer(flex: 10),
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
    bool isDoctor = auth.currentUser!.email == doctorEmail;
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
            child: Icon(Icons.attach_file, color: Colors.grey),
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
              onChanged: (text) => onTyping(text.trim().isNotEmpty),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 13),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[300],
            ),
            child: IconButton(
              icon:
                  Icon(isTyping ? Icons.send : Icons.mic, color: Colors.white),
              onPressed: () {
                if (isTyping) {
                  sendMessage();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
