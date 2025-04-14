import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:garduationproject/bloc/ai_chat_cubit.dart';
import 'package:garduationproject/model/Ai_models/activities.dart';
import 'package:garduationproject/model/Ai_models/child_data.dart';
import 'package:garduationproject/model/Ai_models/mood_ranges.dart';
import 'package:garduationproject/model/Ai_models/progress.dart';
import 'package:garduationproject/model/Ai_models/support_recommendations.dart';

class AiChat extends StatefulWidget {
  static const String routeName = 'Aichat';
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  final TextEditingController messageController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiChatCubit(
        firestore: FirebaseFirestore.instance,
        childData: childData,
      ),
      child: BlocConsumer<AiChatCubit, AiChatState>(
        listener: (context, state) {
          if (state is AiChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppbarAiChat(),
            body: Column(
              children: [
                Expanded(
                  child: state is AiChatsuccsess
                      ? messagesListFromState(state.messages)
                      : const Center(child: CircularProgressIndicator()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: messageController,
                    decoration:
                        const InputDecoration(hintText: 'Type a message'),
                    onSubmitted: (message) {
                      if (message.isNotEmpty) {
                        context.read<AiChatCubit>().sendMessage(message);
                        messageController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
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

  Widget messagesListFromState(List<QueryDocumentSnapshot> messages) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        var messageData = messages[index].data() as Map<String, dynamic>;
        bool isUser = messageData['sender'] == 'user';

        return Align(
          alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
          child: BubbleSpecialThree(
            text: messageData['message'],
            color: isUser ? Colors.white : Colors.blue,
            tail: true,
            isSender: !isUser,
          ),
        );
      },
    );
  }
}
