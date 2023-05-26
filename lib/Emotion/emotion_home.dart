import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EmotionHome extends StatefulWidget {
  EmotionHome({Key? key}) : super(key: key);

  @override
  State<EmotionHome> createState() => _EmotionHomeState();
}

class _EmotionHomeState extends State<EmotionHome> {
  String detectedEmotion = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emotion Detector"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                selectImage();
              },
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                detectEmotion();
              },
              child: Text('Detect Emotion'),
            ),
            SizedBox(height: 20),
            Text(
              'Detected Emotion: $detectedEmotion',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  late final ImagePicker _imagePicker = ImagePicker();
  late PickedFile? _pickedFile;

  Future<void> selectImage() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedFile = pickedFile;
    });
  }

  Future<void> detectEmotion() async {
    if (_pickedFile != null) {
      var bytes = await _pickedFile!.readAsBytes();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.3:5050/emotion_detection'),
      );
      request.files.add(
        http.MultipartFile.fromBytes('image', bytes,
            filename: 'selected_image.jpg'),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var json = jsonDecode(responseBody);
        setState(() {
          detectedEmotion = json['emotion'];
        });
      } else {
        print('Failed to detect emotion. Status code: ${response.statusCode}');
      }
    } else {
      print('No image selected.');
    }
  }
}
