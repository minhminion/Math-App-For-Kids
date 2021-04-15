import 'package:flutter/cupertino.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';
import 'package:math_app_for_kid/services/store/database_helper.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:provider/provider.dart';

class GameProvider extends ChangeNotifierSafety {
  LessonProvider _lessonProvider;

  GamePlay game;
  int _currentGameIndex = 0;

  String errorMessage;
  bool isLoading = false;
  bool isComplete = false;

  BuildContext _context;

  int get currentGameIndex => _currentGameIndex;

  Future<void> startGame({int gameId, BuildContext context}) async {
    this.isComplete = false;
    this._context = context;
    this._lessonProvider = context.provider<LessonProvider>();

    context.read<CharacterProvider>().changeAnimation(CharacterType.idle);

    if (gameId == game?.id) return;

    this.isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    this._currentGameIndex = _lessonProvider.currentLesson.gameplays
        .indexWhere((element) => element.id == gameId);

    await getGameById(gameId: gameId);
    this.isLoading = false;
    notifyListeners();
  }

  Future<bool> getGameById({int gameId}) async {
    this.isComplete = false;

    try {
      Map<String, dynamic> response =
          await DatabaseHelper.dbHelper.getById(GamePlay.tableName, gameId);

      if (response.isNotEmpty) {
        switch (GameType.values[response['gameType'] as int]) {
          case GameType.countGame:
            this.game = CounterGame.fromMap(response);
            break;
          case GameType.mathGame:
            this.game = MathGame.fromMap(response);
            break;
          case GameType.compareGame:
            this.game = CompareGame.fromMap(response);
            break;
          case GameType.shapeGame:
            this.game = ShapeGame.fromMap(response)..createListShape();
            break;
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  bool checkResult(dynamic value) {
    switch (this.game.gameType) {
      case GameType.countGame:
        CounterGame game = this.game;
        isComplete = value == game.result;
        break;
      case GameType.mathGame:
        MathGame game = this.game;
        isComplete = value == game.result;
        break;

      case GameType.compareGame:
        CompareGame game = this.game;
        isComplete = value == game.result;
        break;
      case GameType.shapeGame:
        ShapeGame game = this.game;
        ShapeGameItem gameItem = value;
        if (gameItem.shapeType == ShapeType.values[game.result]) {
          print("Accept Item");
          game.listAcceptItem.add(gameItem);
        }
        isComplete = value == game.result;
        break;
      default:
    }

    notifyListeners();
    return isComplete;
  }

  Future<void> nextGame() async {
    if (_context != null)
      _context.read<CharacterProvider>().changeAnimation(CharacterType.none);

    // Not last game
    List<GamePlay> gamePlays = _lessonProvider.currentLesson.gameplays;
    if (_currentGameIndex < gamePlays.length) {
      this._currentGameIndex++;

      if (_lessonProvider.currentLesson.completedGame < _currentGameIndex) {
        _lessonProvider.updateCurrentLessonCompleteGame(_currentGameIndex);
      }

      if (_currentGameIndex == gamePlays.length) {
        Navigator.pop(_context);
        return;
      }

      int gameId = gamePlays[_currentGameIndex]?.id;
      await getGameById(gameId: gameId);

      notifyListeners();
    }
    return;
  }

  @override
  void resetState() {}
}
