import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_board_answer_place.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';

// ignore: must_be_immutable
class AdditionAndSubtractionGameQuestion extends StatefulWidget {
  AdditionAndSubtractionGameQuestion({Key key, this.gameData})
      : super(key: key);

  AdditionAndSubtractionGame gameData;

  @override
  _AdditionAndSubtractionGameQuestionState createState() =>
      _AdditionAndSubtractionGameQuestionState();
}

class _AdditionAndSubtractionGameQuestionState
    extends BaseStateful<AdditionAndSubtractionGameQuestion>
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
  Widget build(BuildContext context) {
    super.build(context);
    AdditionAndSubtractionGame gameData = widget.gameData;
    return Column(
      children: [
        Flexible(
            flex: 3,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              int crossAxisCount =
                  gameData.numA > gameData.numB ? gameData.numA : gameData.numB;
              double childAspectRatio = (constraints.maxWidth * 2) /
                  (crossAxisCount * constraints.maxHeight);
              return GridView.count(
                shrinkWrap: true,
                primary: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                children: _buildListImages(
                    gameData.numA, gameData.numB, crossAxisCount),
              );
            })),
        SizedBox(
          height: AppConstant.defaultSpacing * 4,
        ),
        FadeTransition(
          opacity: _animation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNumber(gameData.numA.toString()),
              _buildNumber(gameData.operator),
              _buildNumber(gameData.numB.toString()),
              _buildNumber("="),
              GameAnswerPlace(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumber(String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstant.defaultSpacing),
      child: Center(
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
      ),
    );
  }

  List<Widget> _buildListImages(int numberA, int numberB, int crossAxisCount) {
    List<Widget> list = [];

    // Generate Images for number A
    for (int i = 1; i <= crossAxisCount; i++) {
      if (i <= numberA) {
        list.add(_buildImage(appTheme.assets.planet(1)));
      } else {
        list.add(Container(
          width: double.infinity,
          height: double.infinity,
          // child:
        ));
      }
    }

    // Generate Images for number B
    for (int i = 1; i <= crossAxisCount; i++) {
      if (i <= numberB) {
        list.add(_buildImage(appTheme.assets.planet(2)));
      } else {
        list.add(Container(
          width: double.infinity,
          height: double.infinity,
          // child:
        ));
      }
    }

    return list;
  }

  Widget _buildImage(String url) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        padding: EdgeInsets.all(AppConstant.defaultSpacing * 2),
        alignment: Alignment.center,
        // color: Colors.redAccent,
        child: Image(fit: BoxFit.contain, image: AssetImage(url)),
      ),
    );
  }
}
