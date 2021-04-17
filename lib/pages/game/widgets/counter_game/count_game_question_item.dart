import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class CountingGameQuestionItem extends BaseStateless {
  CountingGameQuestionItem({Key key, this.planetId, this.controller})
      : super(key: key);

  int planetId;
  final AnimationController controller;
  Animation<double> _animation;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);

    _animation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScaleTransition(
      scale: _animation,
      child: Image(
        fit: BoxFit.fitHeight,
        image: AssetImage(appTheme.assets.planet(planetId ?? 2)),
      ),
    );
  }
}
