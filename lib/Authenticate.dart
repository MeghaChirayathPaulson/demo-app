import 'package:dementia_app/HomeScreen.dart';
import 'package:dementia_app/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      String? displayName = FirebaseAuth.instance.currentUser!.displayName;
      User? user = _auth.currentUser;
      return HomeScreen(displayName: displayName, user: user);
    } else {
      return LoginScreen();
    }
  }
}
