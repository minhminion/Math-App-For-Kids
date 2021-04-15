import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:math_app_for_kid/utils/app_assets.dart';

enum GameType { countGame, mathGame, compareGame, shapeGame }

enum CompareGameOption { greater, equal, less }

enum ShapeType { circle, square, rectangle, triangle }

class CounterGame extends GamePlay {
  CounterGame(
      {id,
      bool isComplete,
      lessonId,
      GameType gameType,
      List<int> options,
      int result,
      this.images})
      : super(
            id: id,
            gameType: gameType,
            isComplete: isComplete,
            lessonId: lessonId,
            options: options,
            result: result);

  String images;

  @override
  factory CounterGame.fromMap(Map<String, dynamic> map) => CounterGame(
      id: map['id'],
      options: [map['option1'], map['option2'], map['option3']]
          .map((data) => int.parse(data))
          .toList(),
      result: int.parse(map['result']),
      isComplete: map['isComplete'] == 1 ? true : false,
      lessonId: map['lessonId'],
      gameType: GameType.values[map['gameType'] as int],
      images: map['images']);
}

class MathGame extends GamePlay {
  MathGame(
      {id,
      bool isComplete,
      lessonId,
      GameType gameType,
      List<int> options,
      int result,
      this.operator,
      this.numA,
      this.numB})
      : super(
            id: id,
            gameType: gameType,
            isComplete: isComplete,
            lessonId: lessonId,
            options: options,
            result: result);

  String operator;
  int numA;
  int numB;

  @override
  factory MathGame.fromMap(Map<String, dynamic> map) => MathGame(
        id: map['id'],
        options: [map['option1'], map['option2'], map['option3']]
            .map((data) => int.parse(data))
            .toList(),
        result: int.parse(map['result']),
        isComplete: map['isComplete'] == 1 ? true : false,
        lessonId: map['lessonId'],
        gameType: GameType.values[map['gameType'] as int],
        operator: map['operator'],
        numA: map['numA'],
        numB: map['numB'],
      );
}

class CompareGame extends GamePlay {
  CompareGame(
      {id,
      bool isComplete,
      lessonId,
      GameType gameType,
      List<int> options,
      int result,
      this.numA,
      this.numB})
      : super(
            id: id,
            gameType: gameType,
            isComplete: isComplete,
            lessonId: lessonId,
            options: options,
            result: result);

  int numA;
  int numB;

  @override
  factory CompareGame.fromMap(Map<String, dynamic> map) => CompareGame(
        id: map['id'],
        options: [map['option1'], map['option2'], map['option3']]
            .map((data) => int.parse(data))
            .toList(),
        result: int.parse(map['result']),
        isComplete: map['isComplete'] == 1 ? true : false,
        lessonId: map['lessonId'],
        gameType: GameType.values[map['gameType'] as int],
        numA: map['numA'],
        numB: map['numB'],
      );
}

class ShapeGame extends GamePlay {
  ShapeGame(
      {id,
      bool isComplete,
      lessonId,
      GameType gameType,
      List<int> options,
      int result})
      : super(
            id: id,
            gameType: gameType,
            isComplete: isComplete,
            lessonId: lessonId,
            options: options,
            result: result);

  final int numberCorrect = 4;
  List<ShapeGameItem> listAcceptItem = [];
  List<ShapeGameItem> items = [];

  @override
  factory ShapeGame.fromMap(Map<String, dynamic> map) => ShapeGame(
      id: map['id'],
      options: [map['option1'], map['option2'], map['option3']]
          .map((data) => int.parse(data))
          .toList(),
      result: int.parse(map['result']),
      isComplete: map['isComplete'] == 1 ? true : false,
      lessonId: map['lessonId'],
      gameType: GameType.values[map['gameType'] as int]);

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
}

class GamePlay {
  static final String tableName = 'Gameplays';

  int id;
  GameType gameType;
  bool isComplete;
  int lessonId;
  List<int> options;
  int result;

  GamePlay(
      {this.id,
      this.isComplete,
      this.lessonId,
      this.gameType,
      this.options,
      this.result});

  factory GamePlay.fromMap(Map<String, dynamic> map) => GamePlay(
      id: map['id'],
      options: [map['option1'], map['option2'], map['option3']]
          .map((data) => int.parse(data))
          .toList(),
      result: int.parse(map['result']),
      isComplete: map['isComplete'] == 1 ? true : false,
      lessonId: map['lessonId'],
      gameType: GameType.values[map['gameType'] as int]);

  Map<String, dynamic> toMap() => {
        'id': id,
        'isComplete': isComplete == true ? 1 : 0,
        'lessonId': lessonId,
      };
}
