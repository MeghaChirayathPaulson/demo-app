import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'img_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic>? userMap;
  final String chatRoomId;
  ChatRoom({required this.chatRoomId, this.userMap});
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: Text(userMap!['name']),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: size.height / 1.25,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroom')
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? map = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>?;
                      return messages(size, map!);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Container(
            height: size.height / 10,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 12,
              width: size.width / 1.1,
              child: Row(
                children: [
                  Container(
                    height: size.height / 17,
                    width: size.width / 1.3,
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () async {
                                final results = await FilePicker.platform
                                    .pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: ['png', 'jpg']);

                                if (results == null) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No file selected'),
                                    ),
                                  );
                                  return null;
                                }

                                final path = results.files.single.path!;
                                final fileName = results.files.single.name;

                                storage
                                    .uploadFile(path, fileName)
                                    .then((value) => print('Done'));
                              },
                              icon: Icon(Icons.photo)),
                          hintText: "Send Message",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  IconButton(onPressed: onSendMessage, icon: Icon(Icons.send))
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser!.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue,
        ),
        child: Text(
          map['message'],
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
