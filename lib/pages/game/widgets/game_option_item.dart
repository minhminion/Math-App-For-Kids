import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GameOptionItem extends BaseStateless {
  GameOptionItem(
      {Key key, this.size = 100.0, this.text, this.isDisable = false})
      : super(key: key);

  factory GameOptionItem.option(
      {Key key,
      double size = 100.0,
      @required int value,
      bool isDisable = false}) {
    return GameOptionItem(
      key: key,
      size: size,
      text: Text(
        value.toString(),
        style: TextStyle(
          fontSize: 40.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      isDisable: isDisable,
    );
  }

  final double size;
  final Text text;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    GameType gameType = context.read<GameProvider>().game.gameType;
    return Container(
        margin: EdgeInsets.all(8.0),
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: isDisable ? Colors.grey : appTheme.successColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: Material(
          color: Colors.transparent,
          child: Center(
              child: gameType == GameType.compareGame
                  ? getCompareString(text.data)
                  : text),
        ));
  }

  Widget getCompareString(String type) {
    if (type != "?") {
      CompareGameOption _compareGameOption =
          CompareGameOption.values[int.parse(type)];
      switch (_compareGameOption) {
        case CompareGameOption.greater:
          return Text(">");
        case CompareGameOption.equal:
          return Text("=");
        case CompareGameOption.less:
          return Text("<");
        default:
          return Text("?");
      }
    }
    return Text("?");
  }
}
