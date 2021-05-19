import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/pages/achievements/achievements_content.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/widgets/w_floating_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AchievementsPage extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  image: AssetImage(appTheme.assets.backgroundLanding_1))),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                  margin: EdgeInsets.all(AppConstant.defaultSpacing * 4),
                  padding: EdgeInsets.all(AppConstant.defaultSpacing * 2),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: appTheme.cardBackgroundColor,
                      borderRadius:
                          BorderRadius.circular(AppConstant.defaultSpacing)),
                  child: AchievementsContent()),
              Positioned(
                  bottom: 0,
                  left: 8,
                  height: 200,
                  child: Image(
                      image: AssetImage(_getCharacterImages(
                          context.read<LessonProvider>().listLesson)))),
            ],
          )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          WFloatingButton(),
        ],
      ),
    );
  }

  String _getCharacterImages(List<Lesson> _listLesson) {
    String imageUrl = "";
    int totalCompletedLesson = 0;

    _listLesson.forEach((element) {
      if (element.completedGame == element.games.length) totalCompletedLesson++;
    });

    switch (totalCompletedLesson) {
      case 0:
        imageUrl = appTheme.assets.characterWithHi;
        break;
      case 1:
        imageUrl = appTheme.assets.characterWithHoodie;
        break;
      case 2:
        imageUrl = appTheme.assets.characterWithSuit;
        break;
      case 3:
        imageUrl = appTheme.assets.characterWithSupermanCape;
        break;
      default:
        imageUrl = appTheme.assets.characterWithCrown;
        break;
    }

    return imageUrl;
  }
}
