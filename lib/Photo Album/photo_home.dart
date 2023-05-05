import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dementia_app/Photo%20Album/add_caption.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late User? currentUser;
  late CollectionReference captionsRef;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    captionsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('captions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Album'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: captionsRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final captionDocs = snapshot.data!.docs;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemCount: captionDocs.length,
            itemBuilder: (context, index) {
              final caption = captionDocs[index].data() as Map<String, dynamic>;

              return Container(
                height: 200,
                child: GestureDetector(
                  onLongPress: () {
                    _showDeleteConfirmationDialog(caption['imageUrl']);
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 8.0),
                      CachedNetworkImage(
                        imageUrl: caption['imageUrl'],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        caption['caption'],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
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

      // Save image URL and caption to Firestore
      final caption = await Navigator.push<String>(
        context,
        MaterialPageRoute(
            builder: (context) => AddCaptionScreen(downloadUrl, currentUser!)),
      );
      if (caption != null) {
        captionsRef.add({
          'imageUrl': downloadUrl,
          'caption': caption,
        });
      }
    }
  }

  Future<void> _showDeleteConfirmationDialog(String imageUrl) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete photo'),
          content: Text('Are you sure you want to delete this photo?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();

                // Remove photo from Firestore and storage
                captionsRef.where('imageUrl', isEqualTo: imageUrl).get().then(
                  (snapshot) {
                    if (snapshot.size > 0) {
                      String docId = snapshot.docs[0].id;
                      captionsRef.doc(docId).delete().then(
                        (_) async {
                          await FirebaseStorage.instance
                              .refFromURL(imageUrl)
                              .delete();
                          setState(() {});
                        },
                      );
                    }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
