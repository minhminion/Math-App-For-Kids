import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/common/game_success.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_board_answer_place.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_board_question.dart';
import 'package:math_app_for_kid/pages/game/widgets/common/game_tutorial.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GameBoard extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: appTheme.cardBackgroundColor,
          borderRadius: BorderRadius.circular(AppConstant.defaultSpacing)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: 0,
              left: -108,
              child: Selector<GameProvider, int>(
                  selector: (_, gameProvider) => gameProvider.currentGameIndex,
                  builder: (_, gameIndex, __) => _buildHeroGameIndex(
                      gameIndex + 1,
                      context
                          .watch<LessonProvider>()
                          .currentLesson
                          .totalGame))),
          _buildGameBoard(context.read<GameProvider>().game.gameType),
          Positioned(
              bottom: -80,
              top: 100,
              child: Selector<GameProvider, bool>(
                  selector: (_, gameProvider) => gameProvider.isComplete,
                  builder: (_, isCompleted, __) => GameSuccess(isCompleted))),
          Selector<GameProvider, int>(
            selector: (_, gameProvider) => gameProvider.currentGameIndex,
            builder: (_, gameIndex, __) => gameIndex == 0 &&
                    context
                            .read<LessonProvider>()
                            .currentLesson
                            .completedGame ==
                        0
                ? GameTutorial(context.read<GameProvider>().game.gameType)
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildGameBoard(GameType gameType) {
    switch (gameType) {
      case GameType.countingGame:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Game Question
            Flexible(
              flex: 3,
              child: GameQuestion(),
            ),
            // Game AnswerPlace
            GameAnswerPlace(),
          ],
        );
      case GameType.additionAndSubtractionGame:
      case GameType.comparasionGame:
        return GameQuestion();
      default:
        return Container();
    }
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
