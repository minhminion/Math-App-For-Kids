import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/pages/lesson/lesson_row.dart';

class LessonListPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lessonAppBar = SliverAppBar(
      backgroundColor: Color(0xFF845EC2),
      pinned: true,
      snap: true,
      floating: true,
      expandedHeight: 120.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40.0),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text('Bài học'),
          background: Image(
            image: AssetImage('assets/base/images/lesson/bg_appbar.jpg'),
            fit: BoxFit.cover,
          )),
    );

    final lessonRow = SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      sliver: SliverFixedExtentList(
        itemExtent: 130.0,
        delegate: SliverChildBuilderDelegate(
          (context, index) => LessonRow(lessons[index]),
          childCount: lessons.length,
        ),
      ),
    );

    return Expanded(
        child: Container(
      color: Color(0xFFB39CD0),
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          lessonAppBar,
          lessonRow,
        ],
      ),
    ));
  }
}
