import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_list_game.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/widgets/w_progess_circular.dart';
import 'package:provider/provider.dart';

class LessonDetailPage extends StatefulWidget {
  LessonDetailPage({Key key, @required this.lessonId}) : super(key: key);

  final int lessonId;

  @override
  _LessonDetailPageState createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends BaseStateful<LessonDetailPage> {
  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    context.read<LessonProvider>().getLessonById(widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Lesson lesson = context.watch<LessonProvider>().currentLesson;

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      floatingActionButton: _lessonFloatingButton(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppConstant.defaultSpacing * 2,
          horizontal: AppConstant.defaultSpacing * 2,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _buildLessonContentBox(lesson),
            _buildLessonThumbnail(lesson: lesson),
            context.watch<LessonProvider>().isLoading
                ? Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ))
                : LessonListGames(
                    lesson: lesson,
                  )
          ],
        ),
      ),
    );
  }

  Hero _buildLessonThumbnail({@required Lesson lesson}) {
    return Hero(
      tag: "lesson_image_${lesson.id}",
      child: WProgessCircular(
        progessPercent: lesson.gameplays.length > 0
            ? lesson.completedGame / lesson.gameplays.length
            : 0,
        child: Image(
          image: AssetImage('assets/base/images/lesson/${lesson.image}'),
          height: AppConstant.defaultSpacing * 13,
          width: AppConstant.defaultSpacing * 13,
        ),
      ),
    );
  }

  Hero _buildLessonContentBox(Lesson lesson) {
    return Hero(
        tag: "lesson_content_${lesson.id}",
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          margin: EdgeInsets.only(top: AppConstant.defaultSpacing * 6),
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
        ));
  }

  Container _lessonFloatingButton() {
    return Container(
      width: 60.0,
      height: 60.0,
      child: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: appTheme.successColor,
        child: Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
