import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class GameSuccess extends BaseStateless {
  GameSuccess(this.isCompleted);

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isCompleted
        ? Lottie.asset(
            appTheme.assets.lottieCongratulations,
            fit: BoxFit.contain,
            repeat: false,
          )
        : Container();
  }
}
