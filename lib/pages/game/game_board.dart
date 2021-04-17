import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/common/game_success.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_board_answer_place.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_board_question.dart';
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
        children: [
          _buildGameBoard(context.read<GameProvider>().game.gameType),
          Positioned(
              bottom: -80,
              top: 100,
              child: Selector<GameProvider, bool>(
                  selector: (_, gameProvider) => gameProvider.isComplete,
                  builder: (_, isCompleted, __) => GameSuccess(isCompleted)))
        ],
      ),
    );
  }

  Widget _buildGameBoard(GameType gameType) {
    switch (gameType) {
      case GameType.countingGame:
      case GameType.additionAndSubtractionGame:
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
      case GameType.comparasionGame:
        return GameQuestion();
      default:
        return Container();
    }
  }
}
