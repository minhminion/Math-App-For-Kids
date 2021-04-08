enum GameType { countGame, mathGame, compareGame }

enum CompareGameOption { greater, equal, less }

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
