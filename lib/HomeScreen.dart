import 'package:dementia_app/Methods.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen"),),
      body: Center(child: TextButton(onPressed: () => logOut(context), child: const Text("Logout"))),
    );
  }
}