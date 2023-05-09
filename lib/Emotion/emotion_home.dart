import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmotionHome extends StatefulWidget {
  const EmotionHome({Key? key}) : super(key: key);

  @override
  State<EmotionHome> createState() => _EmotionHomeState();
}

class _EmotionHomeState extends State<EmotionHome> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the camera controller
    _controller = CameraController(
      // Use the first available camera
      CameraDescription(
        name: '0', // add a unique name for the camera being used
        lensDirection: CameraLensDirection.front,
        sensorOrientation: 90,
      ),
      ResolutionPreset.high,
    );

    // Wait for the controller to initialize before displaying the camera preview
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Emotion Detector'),
      ),
      body: Stack(
        children: [
          CameraPreview(_controller),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _captureImage,
              child: Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _captureImage() async {
    try {
      // Take a photo using the camera
      final image = await _controller.takePicture();

      // Pass the captured image to the detectEmotion function
      final result = await detectEmotion(image.path);

      // Show the detected emotion in a dialog
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Detected Emotion'),
          content: Text(result['emotion'] ?? 'Unknown emotion'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> detectEmotion(String imagePath) async {
    try {
      // Read the image bytes from the file path
      final imageBytes = await File(imagePath).readAsBytes();

      // Send the photo to the API to detect the emotion
      final uri = Uri.parse('http://127.0.0.1:5000/emotion_detection');
      final request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes('image', imageBytes));
      final response = await request.send();
      final responseJson = await response.stream.bytesToString();

      // Return the emotion detection result as a Map
      return json.decode(responseJson);
    } catch (e) {
      print('Error detecting emotion: $e');
      return {};
    }
  }
}
