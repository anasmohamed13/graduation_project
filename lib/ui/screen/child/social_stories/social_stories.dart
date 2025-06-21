// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
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
  bool _isLoading = false;

  final String serverUrl = 'http://10.0.2.2:5000';

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

  Future<bool> testServerConnection() async {
    try {
      print('Testing server connection to: $serverUrl');
      final response = await http.get(
        Uri.parse('$serverUrl/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      print('Server test response status: ${response.statusCode}');
      print('Server test response body: ${response.body}');

      return response.statusCode == 200;
    } catch (e) {
      print('Server connection test failed: $e');
      return false;
    }
  }

  Future<void> generateStory() async {
    final String name = nameController.text.trim();
    final String ageText = ageController.text.trim();
    final String situation = situationController.text.trim();

    if (name.isEmpty || ageText.isEmpty || situation.isEmpty) {
      showSnackBar('Please fill in all fields');
      return;
    }

    final int? age = int.tryParse(ageText);
    if (age == null || age < 1) {
      showSnackBar('Age must be a valid number');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      showSnackBar('Testing server connection...');
      print('=== Starting generateStory function ===');

      final bool isServerReachable = await testServerConnection();

      if (!isServerReachable) {
        showSnackBar(
            'Cannot connect to server at $serverUrl. Please check if Flask app is running and IP is correct.');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      showSnackBar('Server connected! Generating story...');

      final url = Uri.parse('$serverUrl/generate_story');
      final requestData = {
        'child_name': name,
        'age': age,
        'gender': gender,
        'situation': situation,
      };

      print('Sending request to: $url');
      print('Request data: ${json.encode(requestData)}');

      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode(requestData),
          )
          .timeout(const Duration(seconds: 30));

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true && data['story'] != null) {
          final story = data['story'] as String;

          if (story.isNotEmpty) {
            print('Story generated successfully');

            if (!mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StoryResultScreen(story: story),
              ),
            );
          } else {
            showSnackBar('Generated story is empty');
          }
        } else {
          showSnackBar('Server error: ${data['error'] ?? 'Unknown error'}');
        }
      } else {
        String errorMessage = 'Server error (${response.statusCode})';
        try {
          final errorData = json.decode(response.body);
          errorMessage = errorData['error'] ?? errorMessage;
        } catch (e) {
          errorMessage =
              response.body.isNotEmpty ? response.body : errorMessage;
        }
        showSnackBar('Error: $errorMessage');
      }
    } on SocketException catch (e) {
      print('Socket Exception: $e');
      showSnackBar(
          'Network error: Cannot connect to server. Check your connection.');
    } on HttpException catch (e) {
      print('HTTP Exception: $e');
      showSnackBar('HTTP error: $e');
    } on FormatException catch (e) {
      print('Format Exception: $e');
      showSnackBar('Invalid response from server');
    } catch (e) {
      print('General Exception: $e');
      showSnackBar('Unexpected error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        ),
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
                buildDropdown(),
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
                    onPressed: _isLoading ? null : generateStory,
                    child: _isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Generating...",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        : const Text(
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
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

  Widget buildDropdown() {
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
