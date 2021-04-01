import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';
import 'package:math_app_for_kid/services/store/database_helper.dart';

class GameProvider extends ChangeNotifierSafety {
  GamePlay game;
  bool isComplete = false;

  Future getGameById(int gameId) async {
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
