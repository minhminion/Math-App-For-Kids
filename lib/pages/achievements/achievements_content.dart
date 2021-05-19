import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:provider/provider.dart';

class AchievementsContent extends StatefulWidget {
  @override
  _AchievementsContentState createState() => _AchievementsContentState();
}

class _AchievementsContentState extends BaseStateful<AchievementsContent> {
  List<Lesson> _listLesson;

  @override
  void initDependencies(BuildContext context) {
    _listLesson = context.watch<LessonProvider>().listLesson;
    super.initDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(appTheme.assets.trophyImg),
              height: 50,
            ),
            SizedBox(
              width: AppConstant.defaultSpacing,
            ),
            Text(
              "Thành tích của bé",
              style: TextStyle(
                fontFamily: appTheme.assets.fontRoboto,
                color: Colors.white,
                fontSize: 40.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: AppConstant.defaultSpacing,
            ),
            Image(
              image: AssetImage(appTheme.assets.trophyImg),
              height: 50,
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _listLesson.length,
            itemBuilder: (context, index) =>
                _buildLessonAchievement(_listLesson[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildLessonAchievement(Lesson lesson) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(
          left: AppConstant.defaultSpacing * 17,
          right: AppConstant.defaultSpacing),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lesson.title,
            style: TextStyle(
              fontFamily: appTheme.assets.fontRoboto,
              color: Colors.white,
              fontSize: 25.0,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w600,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppConstant.defaultSpacing * 2)),
                  child: LinearProgressIndicator(
                      value: lesson.totalGame != 0
                          ? lesson.completedGame / lesson.totalGame
                          : 0,
                      semanticsLabel: 'Lesson complete',
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          appTheme.successColor),
                      backgroundColor: Colors.black26),
                ),
              ),
              Text(
                "${lesson.completedGame} / ${lesson.totalGame}",
                style: TextStyle(
                  fontFamily: appTheme.assets.fontRoboto,
                  color: Colors.white,
                  fontSize: 25.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
