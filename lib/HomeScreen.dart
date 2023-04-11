import 'package:dementia_app/Calendar&Reminder/calendar_home.dart';
import 'package:dementia_app/Community/chat_home.dart';
import 'package:dementia_app/Emotion/emotion_home.dart';
import 'package:dementia_app/Location%20Tracking/location_main.dart';
import 'package:dementia_app/Methods.dart';
import 'package:dementia_app/Photo%20Album/photo_home.dart';
import 'package:dementia_app/To%20do/todomain.dart';
import 'package:dementia_app/Treatment%20Tracking/treatment_newhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Brain game/game_home.dart';
import 'Location Tracking/loc_home.dart';
import 'Dementia Prediction/prediction.dart';

class HomeScreen extends StatelessWidget {
  final String? displayName;
  final User? user;
  HomeScreen({Key? key, this.displayName, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.28,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(50.0),
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(50.0)),
                  color: Colors.deepPurple,
                ),
                padding: const EdgeInsets.fromLTRB(10, 70, 0, 0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        SizedBox(width: 20),
                        Text(
                          "Home Page",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      child: Text(
                        "Take a Survey",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DementiaSurvey()));
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(15, 140, 15, 0),
                height: MediaQuery.of(context).size.height * 0.28,
                width: MediaQuery.of(context).size.width * 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(blurRadius: 2.0, color: Color(0xFFCFCCC4)),
                    ]),
                child: user == null
                    ? Text('User not signed in')
                    : FutureBuilder<DocumentSnapshot>(
                        future: users.doc(user!.uid).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            String? phone = data['phone'];
                            String? place = data['place'];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: const CircleAvatar(
                                    radius: 28,
                                    backgroundColor:
                                        Color.fromARGB(255, 220, 214, 214),
                                    //backgroundImage: AssetImage(""),
                                    backgroundImage:
                                        AssetImage('assets/user.png'),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "$displayName",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Phone: $phone',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Place: $place',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CalenderHome(),
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 400, 20, 0),
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      color: Color(0xFFCFCCC4)),
                                ]),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 0),
                                      child: CircleAvatar(
                                          radius: 29,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SvgPicture.asset(
                                                "assets/calender.svg"),
                                          ),
                                          backgroundColor:
                                              const Color(0xffdce0eb)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 95, 0, 0),
                                      child: const Text(
                                        "Calender",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => todoApp(),
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 400, 20, 0),
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      color: Color(0xFFCFCCC4)),
                                ]),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 30, 0, 0),
                                      child: CircleAvatar(
                                          radius: 29,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SvgPicture.asset(
                                                "assets/to-do-list.svg"),
                                          ),
                                          backgroundColor:
                                              const Color(0xffdce0eb)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 95, 0, 0),
                                      child: const Text(
                                        "Add your Tasks here",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GameHome(),
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      color: Color(0xFFCFCCC4)),
                                ]),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 30, 0, 0),
                                      child: CircleAvatar(
                                          radius: 29,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SvgPicture.asset(
                                                "assets/braingame.svg"),
                                          ),
                                          backgroundColor:
                                              const Color(0xffdce0eb)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 95, 0, 0),
                                      child: const Text(
                                        "Memory Game",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MyApplication(),
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      color: Color(0xFFCFCCC4)),
                                ]),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 20, 0, 0),
                                      child: CircleAvatar(
                                          radius: 29,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SvgPicture.asset(
                                                "assets/location.svg"),
                                          ),
                                          backgroundColor:
                                              const Color(0xffdce0eb)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 95, 0, 0),
                                      child: const Text(
                                        "Track Location",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatHome(),
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      color: Color(0xFFCFCCC4)),
                                ]),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          11, 30, 0, 0),
                                      child: CircleAvatar(
                                          radius: 29,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SvgPicture.asset(
                                                "assets/filled-chat.svg"),
                                          ),
                                          backgroundColor:
                                              const Color(0xffdce0eb)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 95, 0, 0),
                                      child: const Text(
                                        "Community",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PhotoAlbumScreen(),
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      color: Color(0xFFCFCCC4)),
                                ]),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 30, 0, 0),
                                      child: CircleAvatar(
                                          radius: 26,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SvgPicture.asset(
                                                "assets/image-gallery.svg"),
                                          ),
                                          backgroundColor:
                                              const Color(0xffdce0eb)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 95, 0, 0),
                                      child: const Text(
                                        "Photo Album",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TreatmentRecordsScreen(),
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      color: Color(0xFFCFCCC4)),
                                ]),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 30, 0, 0),
                                      child: CircleAvatar(
                                          radius: 29,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SvgPicture.asset(
                                                "assets/treatment-plan.svg"),
                                          ),
                                          backgroundColor:
                                              const Color(0xffdce0eb)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 95, 0, 0),
                                      child: const Text(
                                        "Treatment    Records",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EmotionHome(),
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      color: Color(0xFFCFCCC4)),
                                ]),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 30, 0, 0),
                                      child: CircleAvatar(
                                          radius: 29,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: SvgPicture.asset(
                                                "assets/Emotion.svg"),
                                          ),
                                          backgroundColor:
                                              const Color(0xffdce0eb)),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          50, 95, 0, 0),
                                      child: const Text(
                                        "Emotion Detection",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Center(
                        child: ElevatedButton(
                            onPressed: () => logOut(context),
                            child: const Text(
                              "Logout",
                            ))),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
