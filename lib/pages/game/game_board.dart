import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/compare_game/compare_game_board_question.dart';
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
      child: _buildGameBoard(context.read<GameProvider>().game.gameType),
    );
  }

  Widget _buildGameBoard(GameType gameType) {
    switch (gameType) {
      case GameType.countGame:
      case GameType.mathGame:
        return Column(
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
      case GameType.compareGame:
        return GameQuestion();
    }
  }
}
