import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:math_app_for_kid/widgets/w_progess_circular.dart';

// ignore: must_be_immutable
class LessonRow extends BaseStateless {
  final Lesson lesson;

  LessonRow(this.lesson);

  Container _lessonThumbnail() => Container(
        // margin: EdgeInsets.symmetric(vertical: 16.0),
        alignment: FractionalOffset.centerLeft,
        child: Hero(
          tag: "lesson_image_${lesson.id}",
          child: WProgessCircular(
            size: 80.0,
            progessPercent: lesson.gameplays.length > 0
                ? lesson.completedGame / lesson.gameplays.length
                : 0,
            child: Image(
              image: AssetImage('assets/base/images/lesson/${lesson.image}'),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
      );

  Hero _lessonCard() => Hero(
        tag: "lesson_content_${lesson.id}",
        child: Container(
          child: _lessonCardContent(),
          height: 124.0,
          margin: EdgeInsets.only(left: 46.0),
          decoration: BoxDecoration(
            color: appTheme.cardBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
        ),
      );

  Container _lessonCardContent() => Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 4.0),
            Text(
              lesson.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: appTheme.assets.fontRoboto,
                color: Colors.white,
                fontSize: 30.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.lessonDetailRoute,
            arguments: lesson.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            _lessonCard(),
            _lessonThumbnail(),
          ],
        ),
      ),
    );
  }
}
