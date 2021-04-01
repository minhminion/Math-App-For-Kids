import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/widgets/counter_game/game_board_answer_place.dart';
import 'package:math_app_for_kid/pages/game/widgets/counter_game/count_game_board_question.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';

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
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: CountGameQuestions(),
          ),
          GameAnswerPlace(),
        ],
      ),
    );
  }
}
