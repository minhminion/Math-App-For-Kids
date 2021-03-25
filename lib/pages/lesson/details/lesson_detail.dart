import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';

class LessonDetailPage extends StatefulWidget {
  LessonDetailPage({Key key, this.lesson}) : super(key: key);

  final Lesson lesson;

  @override
  _LessonDetailPageState createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends BaseStateful<LessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Hero(
          tag: "lesson_image_${widget.lesson.id}",
          child: Image(
            image:
                AssetImage('assets/base/images/lesson/${widget.lesson.image}'),
            height: 92.0,
            width: 92.0,
          ),
        ),
      ),
    );
  }
}
