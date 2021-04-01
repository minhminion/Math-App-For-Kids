import 'dart:async';

import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';
import 'package:math_app_for_kid/services/store/database_helper.dart';

class LessonProvider extends ChangeNotifierSafety {
  List<Lesson> listLesson;
  Lesson lesson;
  bool loadingLesson = false;

  Future<void> fetchAllLesson() async {
    this.listLesson = await DatabaseHelper.dbHelper.getAllLesson();
  }

  Future<void> updateLesson(int lessonId) async {
    // this.lesson = lesson;
    loadingLesson = true;
    notifyListeners();

    dynamic response =
        await DatabaseHelper.dbHelper.getLessonWithGameplays(lessonId);
    this.lesson = response;

    loadingLesson = false;
    // print("End Loading Lesson");
    notifyListeners();
  }

  @override
  void resetState() {}
}
