import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/counter_game/game_option_item.dart';
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
      child: DragTarget<int>(onAccept: (value) {
        if (_gameProvider.checkResult(value))
          setState(() {
            result = value;
          });
      }, builder: (context, candicates, reject) {
        return context.watch<GameProvider>().isComplete
            ? GameOptionItem.option(
                value: result,
              )
            : GameOptionItem(
                text: Text("?"),
                isDisable: true,
              );
      }),
    );
  }
}
