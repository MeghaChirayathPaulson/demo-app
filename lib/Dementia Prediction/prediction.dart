import 'package:dementia_app/Dementia%20Prediction/result.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DementiaSurvey extends StatefulWidget {
  const DementiaSurvey({Key? key}) : super(key: key);

  @override
  _DementiaSurveyState createState() => _DementiaSurveyState();
}

class _DementiaSurveyState extends State<DementiaSurvey> {
  int memoryScore = 1;
  int languageScore = 1;
  int moodBehaviorScore = 1;
  int problemSolvingScore = 1;
  int orientationConfusionScore = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dementia Survey'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCategory(
              'Memory',
              'Ability to remember important events, names, and recent conversations',
              memoryScore,
              (value) {
                setState(() {
                  memoryScore = int.parse(value);
                });
              },
            ),
            _buildCategory(
              'Language',
              'Ability to find the right words, follow a conversation, and express thoughts clearly',
              languageScore,
              (value) {
                setState(() {
                  languageScore = int.parse(value);
                });
              },
            ),
            _buildCategory(
              'Mood and Behavior',
              'Mood changes, including becoming more withdrawn, irritable, or depressed',
              moodBehaviorScore,
              (value) {
                setState(() {
                  moodBehaviorScore = int.parse(value);
                });
              },
            ),
            _buildCategory(
              'Problem-Solving',
              'Ability to manage finances, follow a recipe, or solve problems',
              problemSolvingScore,
              (value) {
                setState(() {
                  problemSolvingScore = int.parse(value);
                });
              },
            ),
            _buildCategory(
              'Orientation and Confusion',
              'Ability to navigate familiar places, keep track of date or time, or understand surroundings',
              orientationConfusionScore,
              (value) {
                setState(() {
                  orientationConfusionScore = int.parse(value);
                });
              },
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                int totalScore = memoryScore +
                    languageScore +
                    moodBehaviorScore +
                    problemSolvingScore +
                    orientationConfusionScore;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setInt('totalScore', totalScore);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DementiaStage()),
                );

                // TODO: Send totalScore to a backend for analysis
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, String description, int value,
      ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(description),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('No difficulty'),
            const Text('Severe difficulty'),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: 1.0,
          max: 10.0,
          divisions: 9,
          onChanged: (newValue) {
            onChanged(newValue.toInt().toString());
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('1'),
            const Text('10'),
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
