import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class GameTutorial extends BaseStateless {
  final GameType gameType;

  GameTutorial(this.gameType);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    switch (gameType) {
      case GameType.none:
      case GameType.countingGame:
        return Positioned(
            bottom: 0,
            right: -60,
            width: MediaQuery.of(context).size.width / 2 - 180,
            child: Transform.rotate(
              angle: -0.5,
              child: Lottie.asset(
                appTheme.assets.lottieTutorialArrow,
                fit: BoxFit.contain,
                repeat: true,
              ),
            ));

      case GameType.shapeGame:
        return Positioned(
            bottom: 0,
            left: -60,
            width: MediaQuery.of(context).size.width / 2 - 60,
            child: Transform.rotate(
              angle: -0.3,
              child: Lottie.asset(
                appTheme.assets.lottieTutorialArrow,
                fit: BoxFit.contain,
                repeat: true,
              ),
            ));
      case GameType.comparasionGame:
        return Positioned(
            bottom: MediaQuery.of(context).size.height / 8,
            right: -60,
            width: MediaQuery.of(context).size.width / 2 - 180,
            child: Transform.rotate(
              angle: -0.1,
              child: Lottie.asset(
                appTheme.assets.lottieTutorialArrow,
                fit: BoxFit.contain,
                repeat: true,
              ),
            ));
      case GameType.additionAndSubtractionGame:
        return Positioned(
            bottom: 0,
            right: -60,
            width: MediaQuery.of(context).size.width / 2 - 180 - 80,
            child: Transform.rotate(
              angle: -0.5,
              child: Lottie.asset(
                appTheme.assets.lottieTutorialArrow,
                fit: BoxFit.contain,
                repeat: true,
              ),
            ));
      default:
        return Container();
    }
  }
}
