import 'dart:async';

import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';
import 'package:math_app_for_kid/services/store/database_helper.dart';

class LessonProvider extends ChangeNotifierSafety {
  List<Lesson> listLesson;
  Lesson currentLesson;
  bool isLoading = false;

  Future<void> fetchAllLesson() async {
    this.listLesson = await DatabaseHelper.dbHelper.getAllLesson();
  }

  Future<void> getLessonById(int lessonId) async {
    currentLesson = listLesson.firstWhere((element) => element.id == lessonId);
  }

  void updateCurrentLessonCompleteGame(int completeGame) {
    this.currentLesson.completedGame = completeGame;
    notifyListeners();
  }

  @override
  void resetState() {}
}
