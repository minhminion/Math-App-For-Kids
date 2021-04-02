import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/game_board.dart';
import 'package:math_app_for_kid/pages/game/game_character.dart';
import 'package:math_app_for_kid/pages/game/widgets/counter_game/game_option_list.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/widgets/w_floating_button.dart';

// ignore: must_be_immutable
class GamePlayPage extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      floatingActionButton: WFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GameCharacter(),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  0,
                  AppConstant.defaultSpacing * 4,
                  AppConstant.defaultSpacing * 4,
                  AppConstant.defaultSpacing * 4),
              child: GameBoard(),
            ),
          ),
          GameOptionList()
        ],
      ),
    );
  }
}
