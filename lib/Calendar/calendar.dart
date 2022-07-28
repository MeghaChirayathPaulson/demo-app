import 'package:flutter/material.dart';
import 'calendar_widget.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('CALENDAR'),
        centerTitle: true,
      ),
      body: const CalendarWidget(),
    );
  }
}
