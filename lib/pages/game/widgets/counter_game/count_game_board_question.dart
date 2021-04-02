import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class CountGameQuestions extends BaseStateless {
  CountGameQuestions({Key key, this.gameData}) : super(key: key);

  CounterGame gameData;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      int crossAxisCount =
          gameData.result > 2 ? (gameData.result / 2).round() : gameData.result;
      double childAspectRadio = gameData.result > 2
          ? (constraints.maxWidth / (gameData.result / 2).round()) /
              (constraints.maxHeight / 2)
          : (constraints.maxWidth / gameData.result) / constraints.maxHeight;
      return GridView.count(
        shrinkWrap: true,
        primary: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRadio,
        children: _buildListQuesion(gameData.result).toList(),
      );
    });
  }

  List<Widget> _buildListQuesion(int length) {
    List<Widget> list = [];

    for (var i = 0; i < length; i++) {
      list.add(Container(
        margin: EdgeInsets.all(8.0),
        // color: Colors.blue,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double size = constraints.maxWidth * 0.5;
          size = size > constraints.maxHeight
              ? constraints.maxHeight * 0.75
              : size;
          return Stack(
            children: [
              Positioned(
                  height: size,
                  width: size,
                  top: (Random().nextDouble() * (constraints.maxHeight - size)),
                  left: (Random().nextDouble() * (constraints.maxWidth - size)),
                  child: _buildQuestionItem()),
            ],
          );
        }),
      ));
    }

    return list;
  }

  Widget _buildQuestionItem() {
    return Image(
      fit: BoxFit.fitHeight,
      image: AssetImage(appTheme.assets.planet(2)),
    );
  }
}
