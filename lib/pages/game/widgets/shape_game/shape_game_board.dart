import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/shape_game/shape_game_answer_place.dart';
import 'package:math_app_for_kid/pages/game/widgets/shape_game/shape_game_option.dart';
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
            child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: appTheme.cardBackgroundColor,
                    borderRadius:
                        BorderRadius.circular(AppConstant.defaultSpacing)),
                child: Selector<GameProvider, int>(
                    selector: (_, _gameProvider) => _gameProvider.game.id,
                    builder: (_, _gameId, __) =>
                        ShapeGameOption(ValueKey(_gameId)))),
          )
        ],
      ),
    );
  }
}
