import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/game_board.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_list.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/widgets/w_floating_button.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class GamePlayPage extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    final riveArtboard = context.watch<CharacterProvider>().riveArtboard;
    super.build(context);
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      floatingActionButton: WFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            // color: Colors.blue,
            padding: EdgeInsets.symmetric(
                horizontal: AppConstant.defaultSpacing * 4),
            child: Material(
              color: Colors.transparent,
              child: riveArtboard == null
                  ? const SizedBox()
                  : Rive(
                      artboard: riveArtboard,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
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
