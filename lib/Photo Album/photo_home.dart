import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dementia_app/Photo%20Album/add_caption.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoAlbumScreen extends StatefulWidget {
  @override
  _PhotoAlbumScreenState createState() => _PhotoAlbumScreenState();
}

class _PhotoAlbumScreenState extends State<PhotoAlbumScreen> {
  List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Album'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('captions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final captionDocs = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: captionDocs.length,
            itemBuilder: (context, index) {
              final caption = captionDocs[index].data() as Map<String, dynamic>;

              return Column(
                children: [
                  SizedBox(height: 8.0),
                  CachedNetworkImage(
                    imageUrl: caption['imageUrl'],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    caption['caption'],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showImagePickerDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    _getImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    _getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = storageRef.putFile(File(pickedFile.path));
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Show add caption screen
      _showAddCaptionScreen(downloadUrl);

      // Save image URL and caption to Firestore
      final caption = await Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (context) => AddCaptionScreen(downloadUrl)),
      );
      if (caption != null) {
        FirebaseFirestore.instance.collection('captions').add({
          'imageUrl': downloadUrl,
          'caption': caption,
        });
      }
    }
  }

  void _showAddCaptionScreen(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCaptionScreen(imageUrl),
      ),
    );
  }
}
