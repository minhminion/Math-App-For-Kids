import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_item.dart';
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
  GameProvider gameProvider;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    gameProvider = context.provider<GameProvider>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      // height: 150.0,
      child: DragTarget<int>(
          onWillAccept: (value) => gameProvider.checkResult(value),
          onAccept: (value) {
            setState(() {
              result = value;
            });
          },
          builder: (context, candicates, reject) {
            print(candicates);
            return context.watch<GameProvider>().isComplete
                ? GameOptionItem.option(
                    value: result,
                  )
                : GameOptionItem(
                    text: Text("?"),
                  );
          }),
    );
  }
}
