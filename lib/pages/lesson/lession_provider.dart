import 'dart:async';

import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';
import 'package:math_app_for_kid/services/store/database_helper.dart';

class LessonProvider extends ChangeNotifierSafety {
  List<Lesson> listLesson;
  bool loadingLesson = false;

  Future<void> fetchAllLesson() async {
    this.listLesson = await DatabaseHelper.dbHelper.getAllLesson();
  }

  @override
  void resetState() {}
}
