import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';

// ignore: must_be_immutable
class MathGameQuestion extends StatelessWidget {
  MathGameQuestion({Key key, this.gameData}) : super(key: key);

  MathGame gameData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNumber(gameData.numA.toString()),
        _buildNumber(gameData.operator),
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
