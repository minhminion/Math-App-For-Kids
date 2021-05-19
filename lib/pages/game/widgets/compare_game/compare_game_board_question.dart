import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_board_answer_place.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';

class ComparasionGameQuestion extends StatefulWidget {
  final ComparasionGame gameData;

  const ComparasionGameQuestion({Key key, this.gameData}) : super(key: key);

  @override
  _ComparasionGameQuestionState createState() =>
      _ComparasionGameQuestionState();
}

class _ComparasionGameQuestionState
    extends BaseStateful<ComparasionGameQuestion>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
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
    return Column(
      children: [
        Expanded(
            child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: AppConstant.defaultSpacing * 2),
          child: Row(
            children: [
              Expanded(
                  flex: 1, child: _buildGameQuestion(widget.gameData.numA, 1)),
              SizedBox(
                width: AppConstant.defaultSpacing * 2,
              ),
              Expanded(
                  flex: 1, child: _buildGameQuestion(widget.gameData.numB, 2)),
            ],
          ),
        )),
        FadeTransition(
            opacity: _animation,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumber(widget.gameData.numA.toString()),
                GameAnswerPlace(),
                _buildNumber(widget.gameData.numB.toString()),
              ],
            )),
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

  Widget _buildGameQuestion(int number, int planetId) {
    return LayoutBuilder(builder: (context, constraints) {
      double size = constraints.maxWidth / 2 - AppConstant.defaultSpacing * 3;
      return Wrap(
        spacing: AppConstant.defaultSpacing,
        alignment: planetId == 1 ? WrapAlignment.start : WrapAlignment.end,
        children: [
          ...List<Widget>.filled(
              number,
              Image(
                width: size,
                image: AssetImage(appTheme.assets.planet(planetId)),
              ))
        ],
      );
    });
  }
}
