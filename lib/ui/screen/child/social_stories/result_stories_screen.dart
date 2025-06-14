import 'dart:convert';
import 'package:flutter/material.dart';

class StoryResultScreen extends StatelessWidget {
  final String story;
  final String? base64Image;

  const StoryResultScreen({
    super.key,
    required this.story,
    required this.base64Image,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = (base64Image != null && base64Image!.isNotEmpty)
        ? Image.memory(base64Decode(base64Image!), fit: BoxFit.cover)
        : const SizedBox.shrink();

    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Your Story"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imageWidget,
              ),
              const SizedBox(height: 24),
              Text(
                story,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
