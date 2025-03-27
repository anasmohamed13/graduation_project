import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:garduationproject/model/Ai_models/activities.dart';
import 'package:garduationproject/model/Ai_models/child_data.dart';
import 'package:garduationproject/model/Ai_models/mood_ranges.dart';
import 'package:garduationproject/model/Ai_models/progress.dart';
import 'package:garduationproject/model/Ai_models/support_recommendations.dart';
import 'package:garduationproject/model/Api/api.dart';

class AiChat extends StatefulWidget {
  static const String routeName = 'Aichat';
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Sample child data, replace this with actual data retrieval logic
  final ChildData childData = ChildData(
    mood: "happy",
    moodRanges: MoodRanges(ranges: {}),
    activities: Activities(educational: {}, social: {}, emotional: {}),
    progress: Progress(
        happy: "",
        sad: "",
        angry: "",
        nervous: "",
        excited: "",
        bored: "",
        frustrated: "",
        overwhelmed: ""),
    supportRecommendations: SupportRecommendations(
        happy: "",
        sad: "",
        angry: "",
        nervous: "",
        excited: "",
        bored: "",
        frustrated: "",
        overwhelmed: ""),
  );

  // Method to generate AI response based on child data
  // String generateAiResponse(String userMessage) {
  //   // Use the child data to form a response based on mood, progress, etc.
  //   if (childData.mood == 'happy') {
  //     return "I'm happy to see you're doing well! How can I help you today?";
  //   } else if (childData.mood == 'sad') {
  //     return "I'm sorry you're feeling down. Let's talk and feel better together.";
  //   } else if (childData.mood == 'angry') {
  //     return "I understand you're upset. Take a deep breath and let's talk calmly.";
  //   }
  //   // Add more conditions for other moods and behaviors here
  //   return "I'm here to listen, please share more with me!";
  // }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Send the user message to Firestore
    await firestore.collection('Aichat').add({
      'message': message,
      'sender': 'user',
      'timestamp': DateTime.now(),
    });

    // Generate AI response after the user sends a message
    String aiResponse = await ApiService.sendMessage(message, childData);

    // Send the AI response to Firestore
    await firestore.collection('Aichat').add({
      'message': aiResponse,
      'sender': 'ai',
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Clear the message controller after sending the user message
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbarAiChat(),
      body: Column(
        children: [
          Expanded(child: messagesStream()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(hintText: 'Type a message'),
              onSubmitted: sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppbarAiChat() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_sharp,
            color: Color(0xff8aa1b5)),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'GATO AI CHAT',
        style: TextStyle(
            fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
    );
  }

  // Display messages from Firestore
  Widget messagesStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Aichat')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<QueryDocumentSnapshot<Object?>> messages = snapshot.data!.docs;

        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            var messageData = messages[index].data() as Map<String, dynamic>;
            bool isUser = messageData['sender'] == 'user';

            return Align(
              alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: BubbleSpecialThree(
                text: messageData['message'],
                color: isUser ? Colors.white : Colors.blue,
                tail: true,
                isSender: !isUser,
              ),
            );
          },
        );
      },
    );
  }
}
