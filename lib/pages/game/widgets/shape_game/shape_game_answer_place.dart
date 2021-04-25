import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/bubble.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/widgets/common/game_character.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/shape_game/shape_game_accept_item.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/widgets/w_draw_triangle.dart';
import 'package:provider/provider.dart';

class ShapeGameAnswerPlace extends StatefulWidget {
  @override
  _ShapeGameAnswerPlaceState createState() => _ShapeGameAnswerPlaceState();
}

class _ShapeGameAnswerPlaceState extends BaseStateful<ShapeGameAnswerPlace>
    with TickerProviderStateMixin {
  GameProvider _gameProvider;
  CharacterProvider _characterProvider;

  ShapeGameItem _currentAcceptItem;

  // Width of answer place
  // Every inside with change accordingly.
  double maxWidth = 300.0;

  AnimationController _animationQuestionController;
  Animation<double> _opacityAnimation;

  AnimationController _animationErrorController;
  Animation<double> _offsetAnimationError;

  bool _isAcceptedItem = false;

  bool _isFirstTime = true;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);

    _animationQuestionController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    _opacityAnimation = CurvedAnimation(
      parent: _animationQuestionController,
      curve: Curves.easeIn,
    );

    // Create Error animation
    _animationErrorController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _offsetAnimationError = Tween(begin: 0.0, end: 4.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_animationErrorController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationErrorController.reverse();
            }
          });

    _gameProvider = context.provider<GameProvider>();
    _characterProvider = context.provider<CharacterProvider>();
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1300), () {
      _animationQuestionController.forward(from: 0);
      this._isFirstTime = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: maxWidth,
      margin: EdgeInsets.only(right: AppConstant.defaultSpacing * 2),
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: maxWidth,
            alignment: Alignment.bottomCenter,
            child: GameCharacter(),
          ),
          Selector<GameProvider, ShapeGame>(
              selector: (_, _gameProvider) => _gameProvider.game,
              builder: (_, shapeGame, __) {
                _currentAcceptItem = shapeGame.listAcceptItem.length > 0
                    ? shapeGame
                        .listAcceptItem[shapeGame.listAcceptItem.length - 1]
                    : new ShapeGameItem.blank();
                if (!_isFirstTime) {
                  _animationQuestionController.forward(from: 0);
                }

                return FadeTransition(
                  opacity: _opacityAnimation,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      AnimatedBuilder(
                          animation: _offsetAnimationError,
                          builder: (context, snapshot) {
                            double shakeSize =
                                maxWidth ~/ 100 * _offsetAnimationError.value;
                            return Positioned(
                              left: maxWidth / 2.25 + shakeSize,
                              bottom: maxWidth / 16,
                              right: maxWidth / 9 - shakeSize,
                              height: maxWidth / 3,
                              child: Center(
                                  child: _buildQuesion(
                                      ShapeType.values[shapeGame.result])),
                            );
                          }),
                      Selector<GameProvider, ShapeType>(
                        selector: (_, _gameProvider) => ShapeType
                            .values[(_gameProvider.game as ShapeGame).result],
                        builder: (_, resultType, __) => Container(
                          width: maxWidth,
                          height: maxWidth,
                          margin: EdgeInsets.only(right: 16),
                          child: DragTarget<ShapeGameItem>(
                            onAccept: (ShapeGameItem data) {
                              if (_gameProvider.checkResult(data)) {
                                context
                                    .read<CharacterProvider>()
                                    .changeAnimation(CharacterType.success);
                                _animationQuestionController.reverse();
                                Timer(Duration(seconds: 2), () {
                                  context.read<GameProvider>().nextGame();
                                });
                              } else if (!_isAcceptedItem) {
                                _playAnimation(0);
                                // Kiểm tra Character có đang chuyển động fail ?
                                if (_characterProvider.characterType !=
                                    CharacterType.fail) {
                                  // Change Character Type
                                  _characterProvider
                                      .changeAnimation(CharacterType.fail);
                                  _characterProvider
                                      .showBubble(BubbleType.error);
                                  Timer(Duration(seconds: 3), () {
                                    _characterProvider
                                        .changeAnimation(CharacterType.idle);
                                  });
                                }
                              }
                            },
                            onWillAccept: (data) {
                              _isAcceptedItem = data.shapeType == resultType;
                              return true;
                            },
                            builder: (context,
                                List<ShapeGameItem> candidateData,
                                rejectedData) {
                              List<ShapeGameItem> listItem =
                                  shapeGame.listAcceptItem;
                              if (listItem.length > 0 &&
                                  _currentAcceptItem !=
                                      listItem[listItem.length - 1]) {
                                _currentAcceptItem =
                                    listItem[listItem.length - 1];
                                return ShapeGameAcceptItem(
                                    parentWidth: maxWidth,
                                    imageUrl: _currentAcceptItem.imageUrl);
                              } else {
                                return null;
                              }
                              // if (isSuccess) {
                              //   return ShapeGameAcceptItem(
                              //     animationCotroller: _controller,
                              //   );
                              // } else {
                              //   return null;
                              // }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildQuesion(ShapeType shapeType) {
    double size = maxWidth / 4;
    double borderWidth = size / 10;
    switch (shapeType) {
      case ShapeType.circle:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                  color: appTheme.cardBackgroundColor, width: borderWidth)),
        );
      case ShapeType.square:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                  color: appTheme.cardBackgroundColor, width: borderWidth)),
        );
      case ShapeType.rectangle:
        return Container(
          width: size + size / 4,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                  color: appTheme.cardBackgroundColor, width: borderWidth)),
        );
        break;
      case ShapeType.triangle:
        return CustomPaint(
          size: Size(size, size),
          painter: DrawTriangleShape(
            strokeWidth: borderWidth,
            color: appTheme.cardBackgroundColor,
          ),
        );
        break;
    }
    return Container();
  }

  void _playAnimation(int type) {
    // Type: 0 Error, 1 Success
    switch (type) {
      case 0:
        _animationErrorController.forward(from: 0);
        break;
      default:
    }
  }
}
