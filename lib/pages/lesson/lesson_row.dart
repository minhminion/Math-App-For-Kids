import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';

class LessonRow extends StatelessWidget {
  final Lesson lesson;

  LessonRow(this.lesson);

  @override
  Widget build(BuildContext context) {
    final lessonThumbnail = Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: Image(
        image: AssetImage('assets/base/images/lesson/${lesson.image}'),
        height: 92.0,
        width: 92.0,
      ),
    );

    final lessonCardContent = Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(height: 4.0),
          Text(
            lesson.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    final lessonCard = Container(
      child: lessonCardContent,
      height: 124.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: Color(0xFF333366),
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
    );

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            lessonCard,
            lessonThumbnail,
          ],
        ),
      ),
    );
  }
}
