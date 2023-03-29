import 'dart:io';

import 'package:dementia_app/Treatment%20Tracking/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TreatmentRecordsScreen extends StatefulWidget {
  @override
  _TreatmentRecordsScreenState createState() => _TreatmentRecordsScreenState();
}

class _TreatmentRecordsScreenState extends State<TreatmentRecordsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _treatmentRecordsRef;
  late Stream<QuerySnapshot> _treatmentRecordsStream;

  @override
  void initState() {
    super.initState();
    _treatmentRecordsRef = _firestore.collection('treatment_records');
    _treatmentRecordsStream = _treatmentRecordsRef.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treatment Records'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _treatmentRecordsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No treatment records found.'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['treatmentName']),
                subtitle: Text(data['date']),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TreatmentRecordDetailScreen(
                        treatmentName: data['treatmentName'],
                        date: data['date'],
                        description: data['description'],
                        downloadURL: data['downloadURL'],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddTreatmentRecordDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTreatmentRecordDialog extends StatefulWidget {
  @override
  _AddTreatmentRecordDialogState createState() =>
      _AddTreatmentRecordDialogState();
}

class _AddTreatmentRecordDialogState extends State<AddTreatmentRecordDialog> {
  final TextEditingController _treatmentNameController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _downloadURL;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Treatment Record'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                PlatformFile file = result.files.first;
                // Upload the file to Firebase Storage and get the download URL
                Reference ref = FirebaseStorage.instance
                    .ref()
                    .child('treatment_records')
                    .child('${DateTime.now().millisecondsSinceEpoch}');
                UploadTask uploadTask = ref.putFile(File(file.path!));
                TaskSnapshot taskSnapshot =
                    await uploadTask.whenComplete(() {});
                _downloadURL = await taskSnapshot.ref.getDownloadURL();
              }
            },
            child: Text('Select file'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              final newRecord = TreatmentRecord(
                treatmentName: _treatmentNameController.text,
                date: _dateController.text,
                description: _descriptionController.text,
                downloadURL: _downloadURL,
              );
              // Save the treatment record to Firestore
              await FirebaseFirestore.instance
                  .collection('treatment_records')
                  .add(newRecord.toMap());
              Navigator.of(context).pop(newRecord);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

class TreatmentRecord {
  final String treatmentName;
  final String date;
  final String description;
  final String? downloadURL;

  TreatmentRecord({
    required this.treatmentName,
    required this.date,
    required this.description,
    this.downloadURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'treatmentName': treatmentName,
      'date': date,
      'description': description,
      'downloadURL': downloadURL,
    };
  }
}
