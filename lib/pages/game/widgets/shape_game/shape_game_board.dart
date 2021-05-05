import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/shape_game/shape_game_answer_place.dart';
import 'package:math_app_for_kid/pages/game/widgets/shape_game/shape_game_option.dart';
import 'package:math_app_for_kid/pages/game/widgets/common/game_tutorial.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ShapeGameBoard extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ShapeGameAnswerPlace(),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    top: 0,
                    left: -108,
                    child: Selector<GameProvider, int>(
                        selector: (_, gameProvider) =>
                            gameProvider.currentGameIndex,
                        builder: (_, gameIndex, __) => _buildHeroGameIndex(
                            gameIndex + 1,
                            context
                                .watch<LessonProvider>()
                                .currentLesson
                                .totalGame))),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: appTheme.cardBackgroundColor,
                      borderRadius:
                          BorderRadius.circular(AppConstant.defaultSpacing)),
                ),
                Selector<GameProvider, int>(
                    selector: (_, _gameProvider) => _gameProvider.game.id,
                    builder: (_, _gameId, __) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShapeGameOption(ValueKey(_gameId)),
                        )),
                Selector<GameProvider, int>(
                  selector: (_, gameProvider) => gameProvider.currentGameIndex,
                  builder: (_, gameIndex, __) => gameIndex == 0 &&
                          context
                                  .read<LessonProvider>()
                                  .currentLesson
                                  .completedGame ==
                              0
                      ? Selector<GameProvider, bool>(
                          selector: (_, gameProvider) =>
                              (gameProvider.game as ShapeGame)
                                  .listAcceptItem
                                  .length ==
                              0,
                          builder: (_, isTutorial, __) => isTutorial
                              ? GameTutorial(
                                  context.read<GameProvider>().game.gameType)
                              : Container())
                      : Container(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeroGameIndex(int gameIndex, int totalGame) {
    return Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        color: appTheme.cardBackgroundColor,
        borderRadius: BorderRadius.circular(80),
      ),
      child: Center(
        child: Text(
          "$gameIndex/$totalGame",
          style: TextStyle(
            fontFamily: appTheme.assets.fontRoboto,
            color: Colors.white,
            fontSize: 30.0,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
