import 'package:flutter/cupertino.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';

class GameProvider extends ChangeNotifierSafety {
  GameProvider({@required this.game});

  BaseGamePlay game;
  bool isComplete = false;

  bool checkResult(dynamic value) {
    switch (game.gameType) {
      case GameType.countNumber:
        CounterGame gameData = game.data;
        isComplete = value == gameData.result;
        break;
      default:
    }

    notifyListeners();
    return isComplete;
  }

  @override
  void resetState() {}
}
