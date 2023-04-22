import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCaptionScreen extends StatefulWidget {
  final String imageUrl;
  final User user;

  AddCaptionScreen(this.imageUrl, this.user);

  @override
  _AddCaptionScreenState createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late TextEditingController _captionController;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Caption'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _captionController,
              decoration: InputDecoration(
                labelText: 'Caption',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 0),
            ElevatedButton(
              onPressed: () {
                // save the caption and navigate back to the photo album screen
                String caption = _captionController.text;
                // pass the caption back to the calling screen
                Navigator.pop(context, caption);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
