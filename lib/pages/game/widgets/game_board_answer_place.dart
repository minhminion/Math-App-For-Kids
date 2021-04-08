import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_item.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:provider/provider.dart';

class GameAnswerPlace extends StatefulWidget {
  GameAnswerPlace({Key key}) : super(key: key);

  @override
  _GameAnswerPlaceState createState() => _GameAnswerPlaceState();
}

class _GameAnswerPlaceState extends BaseStateful<GameAnswerPlace> {
  int result = 0;
  GameProvider _gameProvider;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _gameProvider = context.provider<GameProvider>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      child: DragTarget<int>(onAccept: (value) async {
        if (_gameProvider.checkResult(value)) {
          // Change Character Type
          context
              .read<CharacterProvider>()
              .changeAnimation(CharacterType.success);

          setState(() {
            result = value;
          });

          Timer(Duration(seconds: 3), () {
            context.read<GameProvider>().nextGame();
          });
        } else if (context.read<CharacterProvider>().characterType !=
            CharacterType.fail) {
          // Change Character Type
          context.read<CharacterProvider>().changeAnimation(CharacterType.fail);
          Timer(Duration(seconds: 3), () {
            context
                .read<CharacterProvider>()
                .changeAnimation(CharacterType.none);
          });
        }
      }, builder: (context, candicates, reject) {
        return context.watch<GameProvider>().isComplete
            ? GameOptionItem.option(
                value: result,
              )
            : GameOptionItem(
                text: Text(
                  "?",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                isDisable: true,
              );
      }),
    );
  }
}
