import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/lesson/lesson_list_page_body.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_theme.dart';

class LessonListPage extends StatefulWidget {
  @override
  _LessonListPageState createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
  AppTheme appTheme;

  @override
  void initState() {
    super.initState();
    setState(() {
      appTheme = context.appTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    Container _lessonFloatingButton() {
      return Container(
        width: 60.0,
        height: 60.0,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: appTheme.successColor,
          child: Icon(Icons.keyboard_return_outlined),
        ),
      );
    }

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Column(
        children: <Widget>[
          LessonListPageBody(),
        ],
      ),
      floatingActionButton: _lessonFloatingButton(),
    );
  }
}
