import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_guide_compare.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_guide_counter.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_guide_shape.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_guide_math.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/widgets/w_floating_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LessonGuideDialog extends BaseStateless {
  final int lessonId;
  CarouselController _buttonCarouselController = CarouselController();

  LessonGuideDialog({Key key, this.lessonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: AppConstant.defaultSpacing * 3,
          vertical: AppConstant.defaultSpacing * 3),
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Hero(
              tag: 'lesson_guide_$lessonId',
              child: Container(
                  margin: EdgeInsets.all(AppConstant.defaultSpacing * 2),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius:
                        BorderRadius.circular(AppConstant.defaultSpacing),
                  ))),
          Positioned(
            top: AppConstant.defaultSpacing * 3,
            child: Hero(
              tag: 'lesson_guide_title_$lessonId',
              child: Container(
                width: 240,
                child: Icon(
                  Icons.help_outline_outlined,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(AppConstant.defaultSpacing * 2),
              child: _buildGuideContent(
                  context.read<LessonProvider>().currentLesson.games[1])),
          Positioned(
              top: 0,
              right: 0,
              child: ClipOval(
                child: Material(
                  color: Colors.redAccent, // button color
                  child: InkWell(
                    splashColor: appTheme.warningColor, // inkwell color
                    child: SizedBox(
                        width: AppConstant.defaultSpacing * 7,
                        height: AppConstant.defaultSpacing * 7,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 32,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: WFloatingButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 40,
                ),
                onPressed: () {
                  _buttonCarouselController.previousPage();
                },
              )),
          Align(
              alignment: Alignment.centerRight,
              child: WFloatingButton(
                icon: Icon(
                  Icons.chevron_right,
                  size: 40,
                ),
                onPressed: () {
                  _buttonCarouselController.nextPage();
                },
              )),
        ],
      ),
    );
  }

  Widget _buildGuideContent(Game _game) {
    switch (_game.gameType) {
      case GameType.countingGame:
        return LessonGuideCounter(
          carouselController: _buttonCarouselController,
        );
      case GameType.shapeGame:
        return LessonGuideShape(
          carouselController: _buttonCarouselController,
        );
      case GameType.comparasionGame:
        return LessonGuideCompare(
          carouselController: _buttonCarouselController,
        );
      case GameType.additionAndSubtractionGame:
        return LessonGuideAdditionAndSubtraction(
          carouselController: _buttonCarouselController,
          operator: _game.lessonId == 5 ? "-" : "+",
        );
      default:
        break;
    }

    return Container();
  }
}
