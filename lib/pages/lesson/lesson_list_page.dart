import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/lesson/lesson_list_page_body.dart';

class LessonListPage extends StatefulWidget {
  @override
  _LessonListPageState createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            LessonListPageBody(),
          ],
        ),
      ),
    );
  }
}
