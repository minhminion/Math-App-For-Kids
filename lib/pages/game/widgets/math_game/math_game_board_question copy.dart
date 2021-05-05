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
        Expanded(
          child: Container(
            margin: EdgeInsets.all(AppConstant.defaultSpacing * 2),
            alignment: Alignment.center,
            // color: Colors.redAccent,
            child: Wrap(
              // direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              runSpacing: AppConstant.defaultSpacing,
              spacing: AppConstant.defaultSpacing,
              children: _buildListImages(
                  gameData.numA, gameData.numB, gameData.operator),
            ),
          ),
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

  List<Widget> _buildListImages(int numberA, int numberB, String operator) {
    List<Widget> list = [];
    int total = numberA + numberB;
    // Generate Images for Addition Game
    switch (operator) {
      case "+":
        for (int i = 1; i <= total; i++) {
          if (i <= numberA) {
            list.add(_buildImage(url: appTheme.assets.planet(1)));
          } else {
            list.add(_buildImage(url: appTheme.assets.planet(2)));
          }
        }
        break;
      case "-":
        String imageUrl = appTheme.assets.planet(1);
        // Number in Subtraction alway > number B
        for (int i = 1; i <= numberA; i++) {
          if (i <= numberA - numberB) {
            list.add(_buildImage(url: imageUrl));
          } else {
            list.add(_buildImage(url: imageUrl, isDisable: true));
          }
        }
        break;
      default:
    }

    // Generate Images for number B
    // for (int i = 1; i <= crossAxisCount; i++) {
    //   if (i <= numberB) {

    //   } else {
    //     list.add(Container(
    //       width: double.infinity,
    //       height: double.infinity,
    //       // child:
    //     ));
    //   }
    // }

    return list;
  }

  Widget _buildImage({String url, bool isDisable = false}) {
    return Container(
      height: 80,
      width: 80,
      child: ColorFiltered(
        colorFilter: isDisable
            ? AppConstant.greyscale
            : ColorFilter.mode(Colors.transparent, BlendMode.color),
        child: ScaleTransition(
          scale: _animation,
          child: Image(
            fit: BoxFit.contain,
            image: AssetImage(url),
          ),
        ),
      ),
    );
  }
}
