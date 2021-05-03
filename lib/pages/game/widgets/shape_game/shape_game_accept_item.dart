import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/game/widgets/common/game_success.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_sounds.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ShapeGameAcceptItem extends StatefulWidget {
  ShapeGameAcceptItem({Key key, this.imageUrl, this.parentWidth})
      : super(key: key);
  String imageUrl;
  double parentWidth;

  _ShapeGameAcceptItemState createState() => _ShapeGameAcceptItemState();
}

class _ShapeGameAcceptItemState extends BaseStateful<ShapeGameAcceptItem>
    with TickerProviderStateMixin {
  AnimationController _animationCotroller;
  Animation<RelativeRect> _position;
  Animation<double> _scale;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    double position = widget.parentWidth / 2;

    _animationCotroller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);

    _scale = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
        parent: _animationCotroller,
        curve: Interval(0.0, 0.7, curve: Curves.ease)));

    _position = RelativeRectTween(
      begin: RelativeRect.fromLTRB(position, 0, 0, position),
      end: RelativeRect.fromLTRB(0, position, position, 0),
    ).animate(_animationCotroller);

    _animationCotroller.forward(from: 0);
  }

  @override
  void dispose() {
    _animationCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // animationCotroller.forward();
    context
        .read<AudioProvider>()
        .playAudio(AudioType.fx, AppSounds.fxMultimediaAlarm);

    super.build(context);
    return Stack(
      children: [
        Positioned(
            bottom: widget.parentWidth / 4,
            left: 0,
            right: 0,
            child: GameSuccess(true)),
        PositionedTransition(
          rect: _position,
          child: ScaleTransition(
              scale: _scale,
              child: Image(
                width: 80,
                image: AssetImage(widget.imageUrl),
              )),
        ),
      ],
    );
  }
}
