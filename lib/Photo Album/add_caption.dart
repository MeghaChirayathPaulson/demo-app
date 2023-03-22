import 'dart:io';

import 'package:flutter/material.dart';

class AddCaptionScreen extends StatefulWidget {
  final String imageUrl;

  AddCaptionScreen(this.imageUrl);

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
            Image.file(
              File(widget.imageUrl),
              fit: BoxFit.cover,
              height: 300,
            ),
            SizedBox(height: 7),
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
                // save the caption with the corresponding image url
                // you can use a database or a simple map to store the captions
                // for each image
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
