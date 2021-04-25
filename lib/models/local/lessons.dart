import 'package:math_app_for_kid/models/local/games.dart';

class Lesson {
  int id;
  String title;
  String image;
  int completedGame;
  int totalGame;
  List<Game> games;

  Lesson({
    this.id,
    this.title,
    this.image,
    this.completedGame,
    this.totalGame,
    this.games,
  });

  factory Lesson.fromMap(Map<String, dynamic> map) => Lesson(
        id: map['id'],
        title: map['title'],
        image: map['image'],
        completedGame: map['completedGame'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'image': image,
        'completedGame': completedGame,
      };
}
