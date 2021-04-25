import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/compare_game/compare_game_board_question.dart';
import 'package:math_app_for_kid/pages/game/widgets/counter_game/count_game_board_question.dart';
import 'package:math_app_for_kid/pages/game/widgets/math_game/math_game_board_question.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GameQuestion extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Selector<GameProvider, Game>(
      selector: (_, _gameProvider) => _gameProvider.game,
      builder: (_, game, __) => _buildContent(game),
    );
  }

  Widget _buildContent(Game _gameData) {
    switch (_gameData.gameType) {
      case GameType.countingGame:
        return CountingGameQuestions(
          gameData: _gameData as CountingGame,
        );

      case GameType.additionAndSubtractionGame:
        return AdditionAndSubtractionGameQuestion(
          gameData: _gameData as AdditionAndSubtractionGame,
        );

      case GameType.comparasionGame:
        return ComparasionGameQuestion(
          gameData: _gameData as ComparasionGame,
        );
      default:
        return null;
    }
  }
}
