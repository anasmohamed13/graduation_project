// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:garduationproject/model/Ai_models/child_data.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> sendMessage(String message, ChildData childData) async {
    final apiUrl = Uri.parse('http://10.0.2.2:5000/chat'); // API URL

    // Prepare the data to send
    Map<String, dynamic> data = {
      'message': message,
      'child_data': childData.toJson(),
    };

    // Send POST request to the API
    try {
      final response =
          await http.post(apiUrl, body: json.encode(data), headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // Parse the AI response from the API
        final responseBody = json.decode(response.body);
        return responseBody['reply'] ?? "I'm sorry, I didn't understand that.";
      } else {
        return "Error: Could not fetch response from AI.";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
