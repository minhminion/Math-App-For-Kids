import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/pages/game/game_board.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_item.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';

// ignore: must_be_immutable
class GamePlayPage extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    CounterGame game =
        context.provider<GameProvider>().game.data as CounterGame;
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              // height: 40,
              margin: EdgeInsets.all(32.0),
              // width: double.infinity,
              child: GameBoard(),
            ),
          ),
          Container(
              // height: 40,
              width: 150,
              margin: EdgeInsets.fromLTRB(0, 16, 16, 16),
              decoration: BoxDecoration(
                  color: appTheme.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: game.options
                    .map<Widget>((option) => Draggable<int>(
                          data: option,
                          child: GameOptionItem.option(value: option),
                          feedback: GameOptionItem.option(value: option),
                          childWhenDragging: Container(
                            margin: EdgeInsets.all(8.0),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ))
                    .toList(),
              )),
        ],
      ),
    );
  }
}
