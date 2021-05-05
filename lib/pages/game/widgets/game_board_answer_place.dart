import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/bubble.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_item.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_list.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_sounds.dart';
import 'package:provider/provider.dart';

class GameAnswerPlace extends StatefulWidget {
  GameAnswerPlace({Key key}) : super(key: key);

  @override
  _GameAnswerPlaceState createState() => _GameAnswerPlaceState();
}

class _GameAnswerPlaceState extends BaseStateful<GameAnswerPlace>
    with TickerProviderStateMixin {
  OptionItem result;
  GameProvider _gameProvider;
  CharacterProvider _characterProvider;
  AnimationController _controller;
  Animation<double> _offsetAnimation;

  double _shakeValues = 16.0;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _offsetAnimation = Tween(begin: 0.0, end: _shakeValues)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            }
          });

    _gameProvider = context.provider<GameProvider>();
    _characterProvider = context.provider<CharacterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AnimatedBuilder(
        animation: _offsetAnimation,
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.only(
                left: _offsetAnimation.value + _shakeValues,
                right: _shakeValues - _offsetAnimation.value),
            child: DragTarget<OptionItem>(onAccept: (value) async {
              if (_gameProvider.checkResult(value.value)) {
                // Change Character Type
                _characterProvider.changeAnimation(CharacterType.success);
                _characterProvider.showBubble(BubbleType.success);
                context
                    .read<AudioProvider>()
                    .playAudio(AudioType.fx, AppSounds.fxMultimediaAlarm);
                setState(() {
                  result = value;
                });

                Timer(Duration(seconds: 3), () {
                  _gameProvider.nextGame();
                });
              } else {
                // Animate Shake effect for answer place
                _controller.forward();
                context
                    .read<AudioProvider>()
                    .playAudio(AudioType.fx, AppSounds.fxBlinkTwice);
                // Kiểm tra Character có đang chuyển động fail ?
                if (_characterProvider.characterType != CharacterType.fail) {
                  // Change Character Type
                  _characterProvider.changeAnimation(CharacterType.fail);
                  _characterProvider.showBubble(BubbleType.error);
                  Timer(Duration(seconds: 3), () {
                    _characterProvider.changeAnimation(CharacterType.idle);
                  });
                }
              }
            }, builder: (context, candicates, reject) {
              return context.watch<GameProvider>().isComplete
                  ? GameOptionItem.option(
                      value: result.value,
                      color: result.color,
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
