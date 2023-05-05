import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TreatmentRecordDetailScreen extends StatelessWidget {
  final String treatmentName;
  final String date;
  final String description;
  final String? downloadURL;
  final String userId;
  final String recordId;

  TreatmentRecordDetailScreen({
    required this.treatmentName,
    required this.date,
    required this.description,
    this.downloadURL,
    required this.userId,
    required this.recordId,
  });

  @override
  Widget build(BuildContext context) {
    DocumentReference recordRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('treatment_records')
        .doc(recordId);

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
