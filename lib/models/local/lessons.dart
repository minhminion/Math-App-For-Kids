import 'package:math_app_for_kid/models/local/game.dart';

class Lesson {
  final String id;
  final String title;
  final String image;
  final int totalGame;
  final List<String> completeGameID;
  final List<BaseGamePlay> data;

  Lesson(
      {this.data,
      this.totalGame,
      this.completeGameID,
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
      completeGameID: [
        "1",
        "2",
        "3"
      ],
      data: <BaseGamePlay>[
        BaseGamePlay<CounterGame>(
            "1", GameType.countNumber, false, CounterGame(5, [1, 2, 5])),
        BaseGamePlay<CounterGame>(
            "2", GameType.countNumber, false, CounterGame(5, [1, 2, 5])),
        BaseGamePlay<CounterGame>(
            "3", GameType.countNumber, false, CounterGame(5, [1, 2, 5])),
        BaseGamePlay<CounterGame>(
            "4", GameType.countNumber, false, CounterGame(5, [1, 2, 5])),
        BaseGamePlay<CounterGame>(
            "5", GameType.countNumber, false, CounterGame(5, [1, 2, 5])),
        BaseGamePlay<CounterGame>(
            "6", GameType.countNumber, false, CounterGame(5, [1, 2, 5])),
      ]),
  Lesson(
      id: "2",
      title: 'Hình vuông - Hình tròn\nHình tam giác - Hình chữ nhật',
      image: 'earth.png',
      totalGame: 10,
      completeGameID: ["1", "2", "3", "5"]),
  Lesson(
      id: "3",
      title: 'Nhiều hơn - Ít hơn - Bằng nhau',
      image: 'mercury.png',
      totalGame: 4,
      completeGameID: ["1", "2", "3"]),
  Lesson(
      id: "4",
      title: 'Phép cộng trong phạm vi 10',
      image: 'moon.png',
      totalGame: 3,
      completeGameID: ["1", "2", "3"]),
  Lesson(
      id: "5",
      title: 'Phép trừ trong phạm vi 10',
      image: 'neptune.png',
      totalGame: 5,
      completeGameID: ["1", "2", "3"]),
];
