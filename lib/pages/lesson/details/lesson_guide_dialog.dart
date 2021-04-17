import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_guide_carousel.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';

// ignore: must_be_immutable
class LessonGuideDialog extends BaseStateless {
  final int lessonId;

  LessonGuideDialog({Key key, this.lessonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: AppConstant.defaultSpacing * 6,
        vertical: AppConstant.defaultSpacing * 6,
      ),
      backgroundColor: Colors.transparent,
      child: Hero(
        tag: 'lesson_guide_$lessonId',
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(AppConstant.defaultSpacing),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Icon(
                Icons.help_outline_outlined,
                size: 40.0,
                color: Colors.white,
              ),
              LessonGuideCarousel(lessonId: lessonId),
            ],
          ),
        ),
      ),
    );
  }
}
