import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/pages/lesson/lesson_row.dart';

class LessonListPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Color(0xFF736AB7),
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          new SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            sliver: new SliverFixedExtentList(
              itemExtent: 145.0,
              delegate: new SliverChildBuilderDelegate(
                (context, index) => LessonRow(lessons[index]),
                childCount: lessons.length,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
