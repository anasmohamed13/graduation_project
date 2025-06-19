// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class EmotionDetectionScreen extends StatefulWidget {
  static const String routeName = 'emotion-detection';
  const EmotionDetectionScreen({super.key});

  @override
  EmotionDetectionScreenState createState() => EmotionDetectionScreenState();
}

class EmotionDetectionScreenState extends State<EmotionDetectionScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isInitialized = false;
  bool isProcessing = false;

  final String apiBaseUrl = 'http://192.168.1.7:5000';

  String? currentEmotion;
  Map<String, dynamic>? emotionScores;
  String? friendlyMessage;
  bool? isPositive;
  String? messageType;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Request camera permission
      await Permission.camera.request();

      // Get available cameras
      cameras = await availableCameras();

      if (cameras!.isNotEmpty) {
        // Initialize the camera controller with front camera if available
        CameraDescription frontCamera = cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => cameras!.first,
        );

        controller = CameraController(
          frontCamera,
          ResolutionPreset.medium,
        );

        await controller!.initialize();

        if (mounted) {
          setState(() {
            isInitialized = true;
          });
        }
      }
    } catch (e) {
      print('Error initializing camera: $e');
      _showErrorDialog(
          'Camera initialization failed. Please check permissions.');
    }
  }

  Future<void> _captureAndAnalyze() async {
    if (!isInitialized || isProcessing || controller == null) return;

    setState(() {
      isProcessing = true;
    });

    try {
      // Capture image
      final XFile image = await controller!.takePicture();

      // Convert image to base64
      final Uint8List imageBytes = await image.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      // Send to Flask API
      await _sendImageToAPI(base64Image);
    } catch (e) {
      print('Error capturing image: $e');
      _showErrorDialog('Failed to capture image: $e');
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  Future<void> _sendImageToAPI(String base64Image) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/detect_emotion'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'image': 'data:image/jpeg;base64,$base64Image',
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          setState(() {
            currentEmotion = data['emotion'];
            emotionScores = data['emotion_scores'];
            friendlyMessage = data['message'];
            isPositive = data['is_positive'];
            messageType = data['message_type'];
          });
        } else if (data['status'] == 'no_face') {
          _showErrorDialog(
              'No face detected. Please make sure your face is visible.');
        } else {
          _showErrorDialog('Error: ${data['message']}');
        }
      } else {
        _showErrorDialog(
            'Failed to connect to emotion detection service. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending image to API: $e');
      _showErrorDialog(
          'Network error. Please check your connection and API server.');
    }
  }

  Future<void> _checkAPIHealth() async {
    try {
      final response = await http.get(Uri.parse('$apiBaseUrl/health'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _showInfoDialog('API Health Check',
            'Status: ${data['status']}\nOpenCV Version: ${data['opencv_version']}');
      } else {
        _showErrorDialog(
            'API is not responding. Status: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog(
          'Cannot connect to API server. Please check if the Flask server is running.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showInfoDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Color _getEmotionColor(String? emotion) {
    switch (emotion) {
      case 'happy':
      case 'excited':
        return Colors.green;
      case 'sad':
      case 'bored':
      case 'overwhelmed':
        return Colors.blue;
      case 'angry':
      case 'frustrated':
        return Colors.red;
      case 'nervous':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getEmotionIcon(String? emotion) {
    switch (emotion) {
      case 'happy':
        return Icons.sentiment_very_satisfied;
      case 'excited':
        return Icons.star;
      case 'sad':
        return Icons.sentiment_dissatisfied;
      case 'angry':
        return Icons.sentiment_very_dissatisfied;
      case 'nervous':
        return Icons.psychology;
      case 'bored':
        return Icons.sentiment_neutral;
      case 'frustrated':
        return Icons.mood_bad;
      case 'overwhelmed':
        return Icons.sentiment_very_dissatisfied_sharp;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kids Emotion Detection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.health_and_safety),
            onPressed: _checkAPIHealth,
            tooltip: 'Check API Health',
          ),
        ],
      ),
      body: Column(
        children: [
          // Camera Preview
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: isInitialized
                  ? CameraPreview(controller!)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),

          // Emotion Results
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: currentEmotion != null
                  ? Column(
                      children: [
                        // Emotion Display
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getEmotionIcon(currentEmotion),
                              size: 40,
                              color: _getEmotionColor(currentEmotion),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              currentEmotion!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _getEmotionColor(currentEmotion),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Friendly Message
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isPositive == true
                                ? Colors.green.shade50
                                : Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isPositive == true
                                  ? Colors.green
                                  : Colors.blue,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            friendlyMessage ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: isPositive == true
                                  ? Colors.green.shade700
                                  : Colors.blue.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Emotion Scores
                        if (emotionScores != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildEmotionScore(
                                  '😊', 'Happy', emotionScores!['happiness']),
                              _buildEmotionScore(
                                  '😢', 'Sad', emotionScores!['sadness']),
                              _buildEmotionScore(
                                  '😠', 'Angry', emotionScores!['anger']),
                            ],
                          ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        'Tap the camera button to detect emotion',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
            ),
          ),

          // Capture Button
          Container(
            padding: const EdgeInsets.all(20),
            child: FloatingActionButton.extended(
              onPressed: isProcessing ? null : _captureAndAnalyze,
              icon: isProcessing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.camera_alt),
              label: Text(isProcessing ? 'Analyzing...' : 'Detect Emotion'),
              backgroundColor: isProcessing ? Colors.grey : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionScore(String emoji, String label, double score) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(
          '${(score * 100).toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
