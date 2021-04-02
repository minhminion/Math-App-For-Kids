import 'package:flutter/cupertino.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';
import 'package:math_app_for_kid/services/store/database_helper.dart';
import 'package:provider/provider.dart';

class GameProvider extends ChangeNotifierSafety {
  GamePlay game;
  String errorMessage;
  bool isLoading = false;
  bool isComplete = false;

  Future<bool> getGameById(int gameId, BuildContext context) async {
    this.isComplete = false;
    if (context != null)
      context.read<CharacterProvider>().changeAnimation(CharacterType.idle);

    if (gameId == game?.id) return true;

    this.isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    try {
      Map<String, dynamic> response =
          await DatabaseHelper.dbHelper.getById(GamePlay.tableName, gameId);

      if (response.isNotEmpty) {
        switch (GameType.values[response['gameType'] as int]) {
          case GameType.countGame:
            this.game = CounterGame.fromMap(response);
            break;
          case GameType.mathGame:
            // TODO: Handle this case.
            break;
        }
      }

      this.isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      this.isLoading = false;
      notifyListeners();
      return false;
    }
  }

  bool checkResult(dynamic value) {
    switch (this.game.gameType) {
      case GameType.countGame:
        CounterGame game = this.game;
        isComplete = value == game.result;
        break;
      default:
    }

    notifyListeners();
    return isComplete;
  }

  @override
  void resetState() {}
}
