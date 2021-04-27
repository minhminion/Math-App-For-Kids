import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/store/database_helper.dart';

class MyTestPage extends StatefulWidget {
  @override
  _MyTestPageState createState() => _MyTestPageState();
}

class _MyTestPageState extends State<MyTestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text('Text page'),
      ),
      body: Center(
        child: TextButton(
          child: Text('Click me'),
          onPressed: () async {
            // var testGame = CountingGame(
            //   id: 1,
            //   result: 2,
            //   isCompleted: true,
            //   lessonId: 1,
            //   gameType: GameType.countingGame,
            //   options: [3, 4, 5],
            // );
            // var update = await DatabaseHelper.dbHelper.updateGame(testGame);
            // print(update);
            var games = await DatabaseHelper.dbHelper.getGameByLessonId(1);
            games.forEach((game) {
              print('${game.toMap()} + ${game.gameType}');
            });
          },
        ),
      ),
    );
  }
}
