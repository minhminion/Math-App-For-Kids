import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/lesson/lesson_list_page_body.dart';

class LessonListPage extends StatefulWidget {
  @override
  _LessonListPageState createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  @override
  Widget build(BuildContext context) {
    Container _lessonFloatingButton() {
      return Container(
        width: 60.0,
        height: 60.0,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Color(0xFF008E9B),
          child: Icon(Icons.keyboard_return_outlined),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            LessonListPageBody(),
          ],
        ),
      ),
      floatingActionButton: _lessonFloatingButton(),
    );
  }
}
