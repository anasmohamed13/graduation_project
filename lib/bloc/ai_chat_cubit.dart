// lib/cubits/ai_chat_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garduationproject/model/Ai_models/child_data.dart';
import 'package:garduationproject/model/Api/api.dart';

// Define states
abstract class AiChatState {}

class AiChatInitial extends AiChatState {}

class AiChatLoading extends AiChatState {}

class AiChatLoaded extends AiChatState {
  final List<QueryDocumentSnapshot> messages;

  AiChatLoaded(this.messages);
}

class AiChatError extends AiChatState {
  final String errorMessage;

  AiChatError(this.errorMessage);
}

// Define Cubit
class AiChatCubit extends Cubit<AiChatState> {
  final FirebaseFirestore firestore;
  final ChildData childData;
  StreamSubscription? messagesSubscription;

  AiChatCubit({
    required this.firestore,
    required this.childData,
  }) : super(AiChatInitial()) {
    // Load initial messages when created
    loadMessages();
  }

  void loadMessages() {
    emit(AiChatLoading());

    try {
      messagesSubscription?.cancel();
      messagesSubscription = firestore
          .collection('Aichat')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        emit(AiChatLoaded(snapshot.docs));
      }, onError: (error) {
        emit(AiChatError("Failed to load messages: $error"));
      });
    } catch (e) {
      emit(AiChatError("Error setting up message listener: $e"));
    }
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    try {
      // Add user message to Firestore
      await firestore.collection('Aichat').add({
        'message': message,
        'sender': 'user',
        'timestamp': DateTime.now(),
      });

      // Get AI response
      String aiResponse = await ApiService.sendMessage(message, childData);

      // Add AI response to Firestore
      await firestore.collection('Aichat').add({
        'message': aiResponse,
        'sender': 'ai',
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      emit(AiChatError("Failed to send message: $e"));
    }
  }

  @override
  Future<void> close() {
    messagesSubscription?.cancel();
    return super.close();
  }
}
