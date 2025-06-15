// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:garduationproject/ui/screen/child/social_stories/result_stories_screen.dart';
import 'package:http/http.dart' as http;

class SocialStoriesScreen extends StatefulWidget {
  static const String routeName = 'social_stories';
  const SocialStoriesScreen({super.key});

  @override
  SocialStoriesScreenState createState() => SocialStoriesScreenState();
}

class SocialStoriesScreenState extends State<SocialStoriesScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController(text: '1');
  final TextEditingController situationController = TextEditingController();
  String gender = 'Boy';

  void incrementAge() {
    int age = int.tryParse(ageController.text) ?? 1;
    setState(() {
      ageController.text = (age + 1).toString();
    });
  }

  void decrementAge() {
    int age = int.tryParse(ageController.text) ?? 1;
    if (age > 1) {
      setState(() {
        ageController.text = (age - 1).toString();
      });
    }
  }

  Future<void> generateStory() async {
    final String name = nameController.text.trim();
    final String ageText = ageController.text.trim();
    final String situation = situationController.text.trim();

    if (name.isEmpty || ageText.isEmpty || situation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final int? age = int.tryParse(ageText);
    if (age == null || age < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Age must be a valid number')),
      );
      return;
    }

    final url = Uri.parse('http://192.168.1.7:5000/generate_story');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'child_name': name,
          'age': age,
          'gender': gender,
          'situation': situation,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final story = data['story'];
        final base64Image = data['image'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StoryResultScreen(
              story: story,
              base64Image: base64Image,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error connecting to API: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF23232A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Generate personalized social stories to support children in social situations.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                buildLabel("Child's Name:"),
                buildTextField(nameController, "Enter your name"),
                const SizedBox(height: 16),
                buildLabel("Child's Age:"),
                Row(
                  children: [
                    buildAgeButton("-", decrementAge),
                    const SizedBox(width: 8),
                    Expanded(
                      child: buildTextField(ageController, "1", isNumber: true),
                    ),
                    const SizedBox(width: 8),
                    buildAgeButton("+", incrementAge),
                  ],
                ),
                const SizedBox(height: 16),
                buildLabel("Child's Gender:"),
                _buildDropdown(),
                const SizedBox(height: 16),
                buildLabel("Describe the situation the child faces:"),
                buildTextField(situationController,
                    "Describe the situation to help the child",
                    maxLines: 3),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: generateStory,
                    child: const Text(
                      "Generate Story",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1, bool isNumber = false}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF2C2C34),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget buildAgeButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: 36,
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C2C34),
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C34),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: gender,
        dropdownColor: const Color(0xFF2C2C34),
        isExpanded: true,
        underline: const SizedBox(),
        style: const TextStyle(color: Colors.white, fontSize: 16),
        items: ['Boy', 'Girl'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            gender = newValue!;
          });
        },
      ),
    );
  }
}
