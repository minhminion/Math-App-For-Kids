enum GameType { countGame, mathGame }

class CounterGame extends GamePlay {
  CounterGame(
      {id,
      bool isComplete,
      lessonId,
      GameType gameType,
      this.options,
      this.result,
      this.images})
      : super(
            id: id,
            gameType: gameType,
            isComplete: isComplete,
            lessonId: lessonId);

  String images;
  List<int> options;
  int result;

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

class GamePlay {
  static final String tableName = 'Gameplays';

  int id;
  GameType gameType;
  bool isComplete;
  int lessonId;

  GamePlay({this.id, this.isComplete, this.lessonId, this.gameType});

  factory GamePlay.fromMap(Map<String, dynamic> map) => GamePlay(
      id: map['id'],
      isComplete: map['isComplete'] == 1 ? true : false,
      lessonId: map['lessonId'],
      gameType: GameType.values[map['gameType'] as int]);

  Map<String, dynamic> toMap() => {
        'id': id,
        'isComplete': isComplete == true ? 1 : 0,
        'lessonId': lessonId,
      };
}
