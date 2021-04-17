import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/counter_game/count_game_question_item.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CountingGameQuestions extends StatefulWidget {
  CountingGameQuestions({Key key, this.gameData}) : super(key: key);

  CountingGame gameData;
  @override
  _CountingGameQuestionsState createState() => _CountingGameQuestionsState();
}

class _CountingGameQuestionsState extends BaseStateful<CountingGameQuestions>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Selector<GameProvider, int>(
        selector: (_, _gameProvider) => _gameProvider.game.id,
        builder: (_, gameId, __) {
          return LayoutBuilder(
              key: ValueKey(gameId),
              builder: (_, BoxConstraints constraints) {
                int crossAxisCount = widget.gameData.result > 2
                    ? (widget.gameData.result / 2).round()
                    : widget.gameData.result;
                double childAspectRadio = widget.gameData.result > 2
                    ? (constraints.maxWidth /
                            (widget.gameData.result / 2).round()) /
                        (constraints.maxHeight / 2)
                    : (constraints.maxWidth / widget.gameData.result) /
                        constraints.maxHeight;
                return GridView.count(
                  shrinkWrap: true,
                  primary: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRadio,
                  children: _buildListQuesion(widget.gameData.result).toList(),
                );
              });
        });
  }

  List<Widget> _buildListQuesion(int length) {
    List<Widget> list = [];
    int planetId =
        1 + Random().nextInt(2); // Generate Planet ID 1 -> 2 to get image

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
                  child: CountingGameQuestionItem(
                    controller: _controller,
                    key: Key(i.toString()),
                    planetId: planetId,
                  )),
            ],
          );
        }),
      ));
    }

    return list;
  }
}
