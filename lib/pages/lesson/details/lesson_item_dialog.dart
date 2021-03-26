import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';

// ignore: must_be_immutable
class LessonItemDialog extends BaseStateless {
  final BaseGamePlay game;

  LessonItemDialog({Key key, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Hero(
        tag: "game_item_${game.id}",
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(AppConstant.defaultSpacing)),
          child: Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      primary: appTheme.successColor,
                      padding: EdgeInsets.all(AppConstant.defaultSpacing * 4)),
                  onPressed: () {},
                  child: Icon(
                    Icons.play_arrow,
                    size: 80.0,
                  ))),
        ),
      ),
    );
  }
}
