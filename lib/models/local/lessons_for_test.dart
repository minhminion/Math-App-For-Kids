import 'package:math_app_for_kid/models/local/game.dart';

class Lesson2 {
  static final String tableName = 'Lessons';

  int id;
  String title;
  String image;
  int totalGame;
  int completedGame;
  List<GamePlay> gameplays;

  Lesson2({
    this.id,
    this.title,
    this.image,
    this.totalGame,
    this.completedGame,
    this.gameplays,
  });

  factory Lesson2.fromMap(Map<String, dynamic> map) => Lesson2(
        id: map['id'],
        title: map['title'],
        image: map['image'],
        totalGame: map['totalGame'],
        completedGame: map['completedGame'],
        // gameplays: map['gameplays'] == null
        //     ? null
        //     : List<GamePlay>.from(
        //         map['gameplays'].map((x) => GamePlay.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'image': image,
        'totalGame': totalGame,
        'completedGame': completedGame,
        // 'gameplays': gameplays == null
        //     ? null
        //     : List<dynamic>.from(gameplays.map((x) => x.toMap())),
      };
}
