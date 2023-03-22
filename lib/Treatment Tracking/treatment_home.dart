import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddTreatmentRecordScreen extends StatefulWidget {
  @override
  _AddTreatmentRecordScreenState createState() =>
      _AddTreatmentRecordScreenState();
}

class _AddTreatmentRecordScreenState extends State<AddTreatmentRecordScreen> {
  final TextEditingController _treatmentNameController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treatment Records'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _treatmentNameController,
              decoration: InputDecoration(
                labelText: 'Treatment Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  PlatformFile file = result.files.first;
                  // handle the selected file here
                }
              },
              child: Text('Select file'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final newRecord = TreatmentRecord(
                  treatmentName: _treatmentNameController.text,
                  date: _dateController.text,
                  description: _descriptionController.text,
                );
                Navigator.of(context).pop(newRecord);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class TreatmentRecord {
  final String treatmentName;
  final String date;
  final String description;

  TreatmentRecord(
      {required this.treatmentName,
      required this.date,
      required this.description});
}
