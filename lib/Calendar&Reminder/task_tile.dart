import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dementia_app/Calendar&Reminder/calendar_home.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> task;
  final int bgColor;

  const TaskTile({Key? key, required this.task, required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(bgColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task['title'],
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${task['startTime']} - ${task['endTime']}",
                        style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 13, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    task['note'],
                    style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task['isCompleted'] == 1 ? "COMPLETED" : "TODO",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Color.fromARGB(255, 103, 58, 183);
      case 1:
        return Color.fromARGB(255, 241, 38, 106);
      case 2:
        return Color.fromARGB(255, 122, 111, 9);
      default:
        return Color.fromARGB(255, 103, 58, 183);
    }
  }
}
