import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_board_answer_place.dart';

// ignore: must_be_immutable
class ComparasionGameQuestion extends StatelessWidget {
  ComparasionGameQuestion({Key key, this.gameData}) : super(key: key);

  ComparasionGame gameData;

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNumber(gameData.numA.toString()),
        GameAnswerPlace(),
        _buildNumber(gameData.numB.toString()),
      ],
    );
  }

  Widget _buildNumber(String value) {
    return Expanded(
      child: Center(
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
      ),
    );
  }
}
