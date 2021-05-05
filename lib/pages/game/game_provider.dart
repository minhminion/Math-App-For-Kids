import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:math_app_for_kid/models/local/bubble.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';
import 'package:math_app_for_kid/services/store/database_helper.dart';
import 'package:math_app_for_kid/utils/app_assets.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:provider/provider.dart';

class GameProvider extends ChangeNotifierSafety {
  LessonProvider _lessonProvider;

  Game game;
  int _currentGameIndex = 0;

  String errorMessage;
  bool isLoading = false;
  bool isComplete = false;

  List<dynamic> rejecteds = [];
  BuildContext _context;

  int get currentGameIndex => _currentGameIndex;

  Future<void> startGame({int gameId, BuildContext context}) async {
    this.isComplete = false;
    this._context = context;
    this._lessonProvider = context.provider<LessonProvider>();

    context.read<CharacterProvider>().changeAnimation(CharacterType.idle);
    context.read<CharacterProvider>().showBubble(BubbleType.hello);

    // if (gameId == game?.id && game.gameType != GameType.shapeGame) return;

    this.isLoading = true;
    notifyListeners();

    this._currentGameIndex = _lessonProvider.currentLesson.games
        .indexWhere((element) => element.id == gameId);

    await getGameById(gameId: gameId);

    await Future.delayed(Duration(seconds: 2));

    this.isLoading = false;
    notifyListeners();
  }

  Future<bool> getGameById({int gameId}) async {
    this.isComplete = false;
    this.rejecteds = [];

    try {
      Map<String, dynamic> gameResponse = await DatabaseHelper.dbHelper
          .getById(DatabaseHelper.gameTable, gameId);

      if (gameResponse.isNotEmpty) {
        Map<String, dynamic> gameClaims =
            await DatabaseHelper.dbHelper.getGameClaimsByGameId(gameId);

        Map<String, dynamic> response = {...gameResponse, ...gameClaims};

        GameType newGameType = GameType.values[response['gameTypeId']];

        // Load character
        if (game == null || newGameType != game.gameType) {
          final bytes = await rootBundle.load(newGameType == GameType.shapeGame
              ? AppAssets.origin().characterWithBoxRiv
              : AppAssets.origin().characterRiv);
          _context.read<CharacterProvider>().setRive(bytes);
        }

        switch (newGameType) {
          case GameType.countingGame:
            this.game = CountingGame.fromMap(response);
            break;
          case GameType.additionAndSubtractionGame:
            this.game = AdditionAndSubtractionGame.fromMap(response);
            break;
          case GameType.comparasionGame:
            this.game = ComparasionGame.fromMap(response);
            break;
          case GameType.shapeGame:
            this.game = ShapeGame.fromMap(response)
              ..createListShape(_currentGameIndex);
            break;
          default:
            break;
        }
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool checkResult(dynamic value) {
    switch (this.game.gameType) {
      case GameType.countingGame:
        CountingGame game = this.game;
        if (value == game.result) {
          isComplete = true;
        } else {
          rejecteds.add(value);
          isComplete = false;
        }
        break;
      case GameType.additionAndSubtractionGame:
        AdditionAndSubtractionGame game = this.game;
        if (value == game.result) {
          isComplete = true;
        } else {
          rejecteds.add(value);
          isComplete = false;
        }
        break;

      case GameType.comparasionGame:
        ComparasionGame game = this.game;
        if (value == game.result) {
          isComplete = true;
        } else {
          rejecteds.add(value);
          isComplete = false;
        }
        break;

      // Result of Shape game
      // - Check shape type of input
      // - If accept all shape with result type => Game Complete!
      case GameType.shapeGame:
        ShapeGame game = this.game;
        ShapeGameItem gameItem = value;
        if (gameItem.shapeType == ShapeType.values[game.result]) {
          game.listAcceptItem.add(gameItem);
        }
        if (game.numberCorrect == game.listAcceptItem.length) {
          isComplete = true;
        }
        break;
      default:
    }

    // Update game isCompleted to DB
    if (isComplete) {
      DatabaseHelper.dbHelper.updateGame(game..isCompleted = true);
    }

    notifyListeners();
    return isComplete;
  }

  Future<void> nextGame() async {
    if (_context != null)
      _context.read<CharacterProvider>().changeAnimation(CharacterType.idle);

    // Not last game
    List<Game> gamePlays = _lessonProvider.currentLesson.games;
    if (_currentGameIndex < gamePlays.length) {
      int _tmpGameIndex = _currentGameIndex + 1;

      if (_lessonProvider.currentLesson.completedGame < _tmpGameIndex) {
        _lessonProvider.updateCurrentLessonCompleteGame(_tmpGameIndex);
      }

      if (_tmpGameIndex == gamePlays.length) {
        Navigator.pop(_context);
        return;
      }

      int gameId = gamePlays[_tmpGameIndex]?.id;
      await getGameById(gameId: gameId);

      this._currentGameIndex = _tmpGameIndex;
      notifyListeners();
    }
    return;
  }

  @override
  void resetState() {}
}
