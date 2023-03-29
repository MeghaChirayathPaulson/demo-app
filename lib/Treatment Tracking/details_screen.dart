import 'package:flutter/material.dart';

class TreatmentRecordDetailScreen extends StatelessWidget {
  final String treatmentName;
  final String date;
  final String description;
  final String? downloadURL;

  TreatmentRecordDetailScreen({
    required this.treatmentName,
    required this.date,
    required this.description,
    this.downloadURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treatment Record Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Treatment Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(treatmentName),
            SizedBox(height: 16.0),
            Text(
              'Date:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(date),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(description),
            if (downloadURL != null) ...[
              SizedBox(height: 16.0),
              Text(
                'Attachment:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement downloading the attachment
                },
                child: Text('Download Attachment'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
