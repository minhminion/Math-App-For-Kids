enum GameType { countNumber }

class BaseGamePlay<T> {
  final String id;
  final GameType gameType;
  final bool isComplete;
  final T data;

  BaseGamePlay(this.id, this.gameType, this.isComplete, this.data);
}

class CounterGame {
  final int result;
  final List<int> options;

  CounterGame(this.result, this.options);
}
