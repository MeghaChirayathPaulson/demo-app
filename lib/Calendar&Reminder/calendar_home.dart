import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dementia_app/Calendar&Reminder/add_task_bar.dart';
import 'package:dementia_app/Calendar&Reminder/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CalenderHome extends StatefulWidget {
  const CalenderHome({key});

  @override
  State<CalenderHome> createState() => _CalenderHomeState();
}

class _CalenderHomeState extends State<CalenderHome> {
  DateTime _selectedDate = DateTime.now();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: subHeadingStyle,
                      ),
                      Text(
                        "Today",
                        style: HeadingStyle,
                      )
                    ],
                  ),
                ),
                MyButton(
                    label: "+ Add Task",
                    onTap: () {
                      Get.to(() => const AddTaskPage());
                    })
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.deepPurple,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              dayTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              monthTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              onDateChange: (date) {
                _selectedDate = date;
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .collection('tasks')
                  .where('date',
                      isEqualTo: DateFormat.yMd().format(_selectedDate))
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tasks = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final task = tasks[index];

                    return Container(
                      color: Color.fromARGB(255, 227, 216, 247),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(task['title']),
                        subtitle: Text(task['note']),
                        trailing: Checkbox(
                          value: task['isCompleted'] == 1,
                          onChanged: (value) {
                            if (value == true) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(_auth.currentUser!.uid)
                                  .collection('tasks')
                                  .doc(task.id)
                                  .delete();
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
}

TextStyle get HeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}
