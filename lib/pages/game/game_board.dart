import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_board_answer_place.dart';
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
          Expanded(
            child: Stack(
              fit: StackFit.loose,
              children: _list(5).toList(),
            ),
          ),
          GameAnswerPlace()
        ],
      ),
    );
  }

  List<Widget> _list(int length) {
    List<Widget> list = [];
    for (var i = 0; i < length; i++) {
      list.add(Positioned(
          top: Random().nextInt(40) * AppConstant.defaultSpacing,
          left: Random().nextInt(60) * AppConstant.defaultSpacing,
          child: Text("i")));
    }

    return list;
  }
}
