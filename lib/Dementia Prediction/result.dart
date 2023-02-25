import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DementiaStage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dementia Stage'),
      ),
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            int totalScore = snapshot.data?.getInt('totalScore') ?? 0;

            String stage;
            if (totalScore >= 40) {
              stage = 'Severe Dementia';
            } else if (totalScore >= 20) {
              stage = 'Moderate Dementia';
            } else {
              stage = 'Mild Dementia';
            }
            return Center(
              child: Text(
                stage,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
