import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LessonItemDialog extends BaseStateless {
  final double iconSize = 80.0;

  final Game game;
  final int gameIndex;

  LessonItemDialog({Key key, this.game, this.gameIndex = 0}) : super(key: key);

  playGame(int gameId, BuildContext context) async {
    await context
        .provider<GameProvider>()
        .startGame(gameId: gameId, context: context);
    Navigator.pushNamed(context, AppRoute.gamePlayRoute, arguments: game.id);
  }

  @override
  Widget build(BuildContext context) {
    bool isCurrentGame =
        context.watch<LessonProvider>().currentLesson.completedGame ==
            gameIndex - 1;

    super.build(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: AppConstant.defaultSpacing * 3,
          vertical: AppConstant.defaultSpacing * 3),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Hero(
            tag: "game_item_${game.id}",
            child: Container(
              margin: EdgeInsets.all(AppConstant.defaultSpacing * 2),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: isCurrentGame ? Colors.blueAccent : Colors.grey,
                  borderRadius:
                      BorderRadius.circular(AppConstant.defaultSpacing)),
              child: Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          primary: appTheme.successColor,
                          padding:
                              EdgeInsets.all(AppConstant.defaultSpacing * 4)),
                      onPressed: () => playGame(game.id, context),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              child: child, scale: animation);
                        },
                        child: context.watch<GameProvider>().isLoading
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 8,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                                height: iconSize,
                                width: iconSize,
                              )
                            : Icon(
                                Icons.play_arrow,
                                size: iconSize,
                              ),
                      ))),
            ),
          ),
          Positioned(
              top: AppConstant.defaultSpacing * 3.5,
              left: AppConstant.defaultSpacing * 3.5,
              child: _buildHeroGameIndex()),
          if (!isCurrentGame)
            Positioned(
              right: AppConstant.defaultSpacing * 8,
              top: AppConstant.defaultSpacing * 2,
              child: Hero(
                tag: "game_item_trophy_${game.id}",
                child: Image(
                  image: AssetImage(appTheme.assets.gameTrophy),
                  height: AppConstant.defaultSpacing * 10,
                  width: AppConstant.defaultSpacing * 10,
                ),
              ),
            ),
          Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: "game_item_closebtn_${game.id}",
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
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildHeroGameIndex() {
    return Hero(
      tag: "game_item_index_${game.id}",
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            color: appTheme.errorColor,
            border: Border.all(color: Colors.white, width: 4),
            borderRadius: BorderRadius.all(Radius.circular(80))),
        child: Center(
          child: Text(
            gameIndex.toString(),
            style: TextStyle(
              fontFamily: appTheme.assets.fontRoboto,
              color: Colors.white,
              fontSize: 30.0,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
