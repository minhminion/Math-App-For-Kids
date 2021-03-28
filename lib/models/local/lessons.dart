import 'package:math_app_for_kid/models/local/game.dart';

class Lesson {
  final String id;
  final String title;
  final String image;
  final int totalGame;
  final int completedGame;
  final List<BaseGamePlay> data;

  Lesson(
      {this.data,
      this.totalGame,
      this.completedGame,
      this.id,
      this.title,
      this.image});
}

List<Lesson> lessons = [
  Lesson(
      id: "1",
      title: 'Đếm các số trong phạm vi 10',
      image: 'mars.png',
      totalGame: 5,
      completedGame: 3,
      data: <BaseGamePlay>[
        CounterGamePlay(
            "1", GameType.countNumber, false, CounterGame(1, [1, 2, 5])),
        CounterGamePlay(
            "2", GameType.countNumber, false, CounterGame(2, [8, 2, 5])),
        CounterGamePlay(
            "3", GameType.countNumber, false, CounterGame(10, [10, 2, 5])),
        CounterGamePlay(
            "4", GameType.countNumber, false, CounterGame(8, [1, 8, 5])),
        CounterGamePlay(
            "5", GameType.countNumber, false, CounterGame(5, [1, 2, 5])),
        CounterGamePlay(
            "6", GameType.countNumber, false, CounterGame(7, [7, 2, 5])),
      ]),
  Lesson(
    id: "2",
    title: 'Hình vuông - Hình tròn\nHình tam giác - Hình chữ nhật',
    image: 'earth.png',
    totalGame: 10,
    completedGame: 3,
  ),
  Lesson(
    id: "3",
    title: 'Nhiều hơn - Ít hơn - Bằng nhau',
    image: 'mercury.png',
    totalGame: 4,
    completedGame: 3,
  ),
  Lesson(
    id: "4",
    title: 'Phép cộng trong phạm vi 10',
    image: 'moon.png',
    totalGame: 3,
    completedGame: 3,
  ),
  Lesson(
    id: "5",
    title: 'Phép trừ trong phạm vi 10',
    image: 'neptune.png',
    totalGame: 5,
    completedGame: 3,
  ),
];
