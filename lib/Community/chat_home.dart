import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dementia_app/Community/one_to_one_chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  // ignore: non_constant_identifier_names
  void OnSearch() async {
    // ignore: no_leading_underscores_for_local_identifiers
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Home"),
        //actions: [
        //IconButton(onPressed: () => logOut(context), icon: Icon(Icons.logout))
        //],
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: size.height / 20,
                width: size.width / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(height: size.height / 20),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: size.height / 14,
                    width: size.width / 1.2,
                    child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                ElevatedButton(onPressed: OnSearch, child: Text("Search")),
                SizedBox(
                  height: size.height / 30,
                ),
                userMap != null
                    ? ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser!.displayName!,
                              userMap!['name']);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ChatRoom(
                                    chatRoomId: roomId,
                                    userMap: userMap,
                                  )));
                        },
                        leading: const Icon(
                          Icons.account_box,
                          color: Colors.black,
                        ),
                        title: Text(
                          userMap!['name'],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(userMap!['email']),
                        trailing: const Icon(
                          Icons.chat,
                          color: Colors.black,
                        ),
                      )
                    : Container()
              ],
            ),
    );
  }
}
