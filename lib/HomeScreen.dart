import 'package:dementia_app/Calendar&Reminder/calendar_home.dart';
import 'package:dementia_app/Community/chat_home.dart';
import 'package:dementia_app/Emotion/emotion_home.dart';
import 'package:dementia_app/Methods.dart';
import 'package:dementia_app/Photo%20Album/photo_home.dart';
import 'package:dementia_app/To%20do/todomain.dart';
import 'package:dementia_app/Treatment%20Tracking/treatment_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Brain game/game_home.dart';
import 'Location Tracking/loc_home.dart';
import 'Dementia Prediction/prediction.dart';
import 'Treatment Tracking/treatment_newhome.dart';

class HomeScreen extends StatelessWidget {
  final String? displayName;

  HomeScreen({Key? key, this.displayName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(145, 40, 0, 0),
                          child: const CircleAvatar(
                            radius: 28,
                            backgroundColor: Color.fromARGB(255, 220, 214, 214),
                            //backgroundImage: AssetImage(""),
                            backgroundImage: AssetImage('assets/user.png'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(150, 95, 0, 0),
                          child: Text(
                            "$displayName",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(140, 125, 0, 0),
                          child: const Text(
                            "Engineer",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(130, 145, 0, 0),
                          child: const Text(
                            "9900000000",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(140, 166, 0, 0),
                          child: const Text(
                            "Thrissur",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          child: Center(
                              child: TextButton(
                                  onPressed: () => logOut(context),
                                  child: const Text(
                                    "Logout",
                                  ))),
                        ),
                      ],
                    ),
                  ],
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
                                  builder: (_) => Location(),
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
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
