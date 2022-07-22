import 'package:dementia_app/CreateAccount.dart';
import 'package:dementia_app/Methods.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.28,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(50.0),
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(50.0)),
                  color: Color(0xFF2A1758),
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
                  ],
                ),
              ),
              Container(
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
                          padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                          child: const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blue,
                            //backgroundImage: AssetImage('assets/de.jpeg'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 95, 0, 0),
                          child: const Text(
                            "Ansh Sharma",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 125, 0, 0),
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
                          padding: const EdgeInsets.fromLTRB(10, 145, 0, 0),
                          child: const Text(
                            "99xxxxxxxx",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 166, 0, 0),
                          child: const Text(
                            "Thrissur",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(child: Center(child: TextButton(onPressed: () => logOut(context), child: const Text("Logout"))),)
                      ],
                    ),
                  ],
                ),
              ),
        ]
      )
      ,],
        ),
               ); }
}