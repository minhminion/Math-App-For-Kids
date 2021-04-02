import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class GameCharacter extends StatefulWidget {
  GameCharacter({Key key}) : super(key: key);

  @override
  _GameCharacterState createState() => _GameCharacterState();
}

class _GameCharacterState extends BaseStateful<GameCharacter>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)),
    );

    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final riveArtboard = context.watch<CharacterProvider>().riveArtboard;

    return Container(
      width: 200,
      // color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: AppConstant.defaultSpacing * 4),
      child: Material(
        color: Colors.transparent,
        child: riveArtboard == null
            ? const SizedBox()
            : Rive(
                artboard: riveArtboard,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
