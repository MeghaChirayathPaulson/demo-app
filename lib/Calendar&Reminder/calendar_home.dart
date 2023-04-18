import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dementia_app/Calendar&Reminder/add_task_bar.dart';
import 'package:dementia_app/Calendar&Reminder/button.dart';
import 'package:dementia_app/Calendar&Reminder/notifications.dart';
import 'package:dementia_app/Calendar&Reminder/task_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CalenderHome extends StatefulWidget {
  const CalenderHome({key});

  @override
  State<CalenderHome> createState() => _CalenderHomeState();
}

class _CalenderHomeState extends State<CalenderHome> {
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }

  DateTime _selectedDate = DateTime.now();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            notifyHelper.displayNotification(title: "Theme changed");
          },
          child: Icon(
            Icons.nightlight_round,
            size: 20,
          ),
        ),
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
                setState(() {
                  _selectedDate = date;
                });
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
                    if (task['repeat'] == 'Daily') {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                            child: FadeInAnimation(
                                child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, task);
                              },
                              child:
                                  TaskTile(task: task, bgColor: task['color']),
                            )
                          ],
                        ))),
                      );
                    }
                    if (task['date'] ==
                        DateFormat.yMd().format(_selectedDate)) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                            child: FadeInAnimation(
                                child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, task);
                              },
                              child:
                                  TaskTile(task: task, bgColor: task['color']),
                            )
                          ],
                        ))),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context, task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task['isCompleted'] == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]),
          ),
          Spacer(),
          task['isCompleted'] == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Task Completed",
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(_auth.currentUser!.uid)
                        .collection('tasks')
                        .doc(task.id)
                        .update({
                      'isCompleted': 1,
                    });
                    Get.back();
                  },
                  clr: Colors.deepPurple,
                  context: context,
                ),
          _bottomSheetButton(
            label: "Delete Task",
            onTap: () {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .collection('tasks')
                  .doc(task.id)
                  .delete();

              Get.back();
            },
            clr: Color.fromARGB(255, 249, 94, 83),
            context: context,
          ),
          const SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
            label: "Close",
            onTap: () {
              Get.back();
            },
            clr: Color.fromARGB(255, 249, 94, 83),
            isClose: true,
            context: context,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}

_bottomSheetButton(
    {required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2, color: isClose == true ? Colors.grey[300]! : clr),
        borderRadius: BorderRadius.circular(20),
        color: isClose == true ? Colors.transparent : clr,
      ),
      child: Center(
          child: Text(
        label,
        style: isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
      )),
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
}

TextStyle get HeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}
