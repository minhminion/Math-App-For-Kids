import 'dart:async';

import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';

class LessonProvider extends ChangeNotifierSafety {
  Lesson lesson;
  bool loadingLesson = true;

  Future<void> updateLesson(Lesson lesson) async {
    this.lesson = lesson;
    // TODO: Get game detail
    // Fake call DB
    // print("Start Loading Lesson");
    loadingLesson = true;
    notifyListeners();

    var duration = new Duration(seconds: 2);
    new Timer(duration, () {
      loadingLesson = false;
      // print("End Loading Lesson");
      notifyListeners();
    });
  }

  @override
  void resetState() {}
}
