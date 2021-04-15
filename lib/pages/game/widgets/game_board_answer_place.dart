import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_item.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:provider/provider.dart';

class GameAnswerPlace extends StatefulWidget {
  GameAnswerPlace({Key key}) : super(key: key);

  @override
  _GameAnswerPlaceState createState() => _GameAnswerPlaceState();
}

class _GameAnswerPlaceState extends BaseStateful<GameAnswerPlace>
    with TickerProviderStateMixin {
  int result = 0;
  GameProvider _gameProvider;
  AnimationController _controller;
  Animation<double> _offsetAnimation;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            }
          });

    _gameProvider = context.provider<GameProvider>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AnimatedBuilder(
        animation: _offsetAnimation,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(
                left: _offsetAnimation.value + 60.0,
                right: 60.0 - _offsetAnimation.value),
            child: DragTarget<int>(onAccept: (value) async {
              if (_gameProvider.checkResult(value)) {
                // Change Character Type
                context
                    .read<CharacterProvider>()
                    .changeAnimation(CharacterType.success);

                setState(() {
                  result = value;
                });

                Timer(Duration(seconds: 3), () {
                  context.read<GameProvider>().nextGame();
                });
              } else {
                // Animate Shake effect for answer place
                _controller.forward();

                // Kiểm tra Character có đang chuyển động fail ?
                if (context.read<CharacterProvider>().characterType !=
                    CharacterType.fail) {
                  // Change Character Type
                  context
                      .read<CharacterProvider>()
                      .changeAnimation(CharacterType.fail);
                  Timer(Duration(seconds: 3), () {
                    context
                        .read<CharacterProvider>()
                        .changeAnimation(CharacterType.none);
                  });
                }
              }
            }, builder: (context, candicates, reject) {
              return context.watch<GameProvider>().isComplete
                  ? GameOptionItem.option(
                      value: result,
                    )
                  : GameOptionItem(
                      text: Text(
                        "?",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      isDisable: true,
                    );
            }),
          );
        });
  }
}
