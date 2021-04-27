import 'dart:math';

import 'package:math_app_for_kid/utils/app_assets.dart';

enum GameType {
  none,
  countingGame,
  shapeGame,
  comparasionGame,
  additionAndSubtractionGame
}

enum ComparasionGameOption { greater, equal, less }

enum ShapeType { circle, square, rectangle, triangle }

class Game {
  int id;
  bool isCompleted;
  int result;
  int lessonId;
  GameType gameType;
  // List<GameClaim> gameClaims;

  Game({
    this.id,
    this.isCompleted,
    this.result,
    this.lessonId,
    this.gameType,
    // this.gameClaims,
  });

  factory Game.fromMap(Map<String, dynamic> map) => Game(
        id: map['id'],
        result: int.parse(map['result']),
        isCompleted: map['isCompleted'] == 1 ? true : false,
        lessonId: map['lessonId'],
        gameType: GameType.values[map['gameTypeId'] as int],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'result': result,
        'isCompleted': isCompleted == true ? 1 : 0,
        'lessonId': lessonId,
        'gameTypeId': gameType.index,
      };
}

class CountingGame extends Game {
  CountingGame({
    int id,
    bool isCompleted,
    int lessonId,
    GameType gameType,
    int result,
    this.options,
  }) : super(
          id: id,
          gameType: gameType,
          isCompleted: isCompleted,
          lessonId: lessonId,
          result: result,
        );

  List<int> options;

  @override
  factory CountingGame.fromMap(Map<String, dynamic> map) => CountingGame(
        id: map['id'],
        options: [map['option1'], map['option2'], map['option3']]
            .map((data) => int.parse(data))
            .toList(),
        result: int.parse(map['result']),
        isCompleted: map['isCompleted'] == 1 ? true : false,
        lessonId: map['lessonId'],
        gameType: GameType.values[map['gameTypeId'] as int],
      );
}

class AdditionAndSubtractionGame extends Game {
  AdditionAndSubtractionGame({
    int id,
    bool isCompleted,
    int lessonId,
    GameType gameType,
    int result,
    this.operator,
    this.options,
    this.numA,
    this.numB,
  }) : super(
          id: id,
          gameType: gameType,
          isCompleted: isCompleted,
          lessonId: lessonId,
          result: result,
        );

  String operator;
  int numA;
  int numB;
  List<int> options;

  @override
  factory AdditionAndSubtractionGame.fromMap(Map<String, dynamic> map) =>
      AdditionAndSubtractionGame(
        id: map['id'],
        options: [map['option1'], map['option2'], map['option3']]
            .map((data) => int.parse(data))
            .toList(),
        result: int.parse(map['result']),
        isCompleted: map['isCompleted'] == 1 ? true : false,
        lessonId: map['lessonId'],
        gameType: GameType.values[map['gameTypeId'] as int],
        numA: int.parse(map['numA']),
        numB: int.parse(map['numB']),
        operator: map['operator'],
      );
}

class ComparasionGame extends Game {
  ComparasionGame({
    int id,
    bool isCompleted,
    int lessonId,
    GameType gameType,
    this.options,
    int result,
    this.numA,
    this.numB,
  }) : super(
          id: id,
          gameType: gameType,
          isCompleted: isCompleted,
          lessonId: lessonId,
          result: result,
        );

  int numA;
  int numB;
  List<int> options;

  @override
  factory ComparasionGame.fromMap(Map<String, dynamic> map) => ComparasionGame(
        id: map['id'],
        options: [map['option1'], map['option2'], map['option3']]
            .map((data) => int.parse(data))
            .toList(),
        result: int.parse(map['result']),
        isCompleted: map['isCompleted'] == 1 ? true : false,
        lessonId: map['lessonId'],
        gameType: GameType.values[map['gameTypeId'] as int],
        numA: int.parse(map['numA']),
        numB: int.parse(map['numB']),
      );
}

class ShapeGame extends Game {
  ShapeGame({
    int id,
    bool isCompleted,
    lessonId,
    GameType gameType,
    int result,
    this.numberCorrect,
  }) : super(
          id: id,
          gameType: gameType,
          isCompleted: isCompleted,
          lessonId: lessonId,
          result: result,
        );

  int numberCorrect = 3;
  List<ShapeGameItem> listAcceptItem = [];
  List<ShapeGameItem> items = [];

  @override
  factory ShapeGame.fromMap(Map<String, dynamic> map) => ShapeGame(
      id: map['id'],
      result: int.parse(map['result']),
      isCompleted: map['isCompleted'] == 1 ? true : false,
      lessonId: map['lessonId'],
      gameType: GameType.values[map['gameTypeId'] as int],
      numberCorrect: int.parse(map['numberCorrect']));

  void createListShape() {
    ShapeType resultType = ShapeType.values[this.result];
    List<ShapeGameItem> list = [];
    int imageId;

    // Create result shape item
    for (int i = 0; i < numberCorrect; i++) {
      imageId = 1 + Random().nextInt(2);
      list.add(ShapeGameItem(
        i,
        resultType,
        AppAssets.origin().getShapeImages(resultType, imageId),
      ));
    }

    // Create random shape item
    for (int i = numberCorrect; i < 9; i++) {
      ShapeType shapeType;
      do {
        shapeType = ShapeType.values[Random().nextInt(4)];
      } while (shapeType == resultType);

      imageId = 1 + Random().nextInt(2);
      list.add(ShapeGameItem(
        i,
        shapeType,
        AppAssets.origin().getShapeImages(shapeType, imageId),
      ));
    }

    list.shuffle();

    this.items = list;
  }
}

class ShapeGameItem {
  int id;
  ShapeType shapeType;
  String imageUrl;

  ShapeGameItem(this.id, this.shapeType, this.imageUrl);

  @override
  factory ShapeGameItem.blank() => ShapeGameItem(0, ShapeType.circle, "");
}
