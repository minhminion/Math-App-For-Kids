import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CountGameQuestionItem extends StatefulWidget {
  CountGameQuestionItem({Key key, this.planetId}) : super(key: key);

  int planetId;

  @override
  _CountGameQuestionItemState createState() => _CountGameQuestionItemState();
}

class _CountGameQuestionItemState extends BaseStateful<CountGameQuestionItem>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
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
    return ScaleTransition(
      scale: _animation,
      child: Image(
        fit: BoxFit.fitHeight,
        image: AssetImage(appTheme.assets.planet(widget.planetId ?? 2)),
      ),
    );
  }
}
