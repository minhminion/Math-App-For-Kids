import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/pages/lesson/lesson_row.dart';
import 'package:math_app_for_kid/pages/lesson/lesson_space_bar.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class LessonListPageBody extends BaseStateless {
  SliverAppBar _lessonAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: appTheme.errorColor,
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: 120.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40.0),
        ),
      ),
      flexibleSpace: LessonSpaceBar(),
      // flexibleSpace: FlexibleSpaceBar(
      //   centerTitle: true,
      //   // title: Text('Bài học'),
      //   background: Image(
      //     image: AssetImage('assets/base/images/lesson/bg_appbar_1.png'),
      //     fit: BoxFit.cover,
      //     alignment: Alignment.center,
      //   ),
      // ),
    );
  }

  SliverPadding _lessonRow() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      sliver: SliverFixedExtentList(
        itemExtent: 130.0,
        delegate: SliverChildBuilderDelegate(
          (context, index) => LessonRow(lessons[index]),
          childCount: lessons.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
        child: Container(
      // color: Color(0xFFB39CD0),
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          _lessonAppBar(),
          _lessonRow(),
        ],
      ),
    ));
  }
}
