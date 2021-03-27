enum GameType { countNumber }

class BaseGamePlay<T> {
  int id;
  GameType gameType;
  bool isComplete;
  T data;

  BaseGamePlay({this.id, this.gameType, this.isComplete, this.data});

  factory BaseGamePlay.fromMap(Map<String, dynamic> map) => BaseGamePlay(
        id: map['id'],
        gameType: map['gameType'],
        isComplete: map['isComplete'],
        data: map['lessonId'],
      );
}

class CounterGamePlay extends BaseGamePlay<CounterGame> {
  CounterGamePlay(int id, GameType gameType, bool isComplete, CounterGame data)
      : super(id: id, data: data, isComplete: isComplete, gameType: gameType);
}

class CounterGame {
  final int result;
  final List<int> options;

  CounterGame(this.result, this.options) : assert(result <= 10);
}

class GamePlay {
  static final String tableName = 'Gameplays';

  int id;
  String option1;
  String option2;
  String option3;
  int numA;
  int numB;
  String operator;
  String result;
  bool isComplete;
  int lessonId;

  GamePlay({
    this.id,
    this.option1,
    this.option2,
    this.option3,
    this.numA,
    this.numB,
    this.operator,
    this.result,
    this.isComplete,
    this.lessonId,
  });

  factory GamePlay.fromMap(Map<String, dynamic> map) => GamePlay(
        id: map['id'],
        option1: map['option1'],
        option2: map['option2'],
        option3: map['option3'],
        numA: map['numA'],
        numB: map['numB'],
        operator: map['operator'],
        result: map['result'],
        isComplete: map['isComplete'] == 1 ? true : false,
        lessonId: map['lessonId'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'numA': numA,
        'numB': numB,
        'operator': operator,
        'result': result,
        'isComplete': isComplete == true ? 1 : 0,
        'lessonId': lessonId,
      };
}
