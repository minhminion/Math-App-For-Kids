import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LessonItemDialog extends BaseStateless {
  final GamePlay game;

  LessonItemDialog({Key key, this.game}) : super(key: key);

  playGame(int gameId, BuildContext context) async {
    await context
        .provider<GameProvider>()
        .startGame(gameId: gameId, context: context);
    Navigator.pushNamed(context, AppRoute.gamePlayRoute, arguments: game.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: AppConstant.defaultSpacing * 6,
          vertical: AppConstant.defaultSpacing * 6),
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
                  onPressed: () => playGame(game.id, context),
                  child: context.watch<GameProvider>().isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              appTheme.errorColor),
                        )
                      : Icon(
                          Icons.play_arrow,
                          size: 80.0,
                        ))),
        ),
      ),
    );
  }
}
