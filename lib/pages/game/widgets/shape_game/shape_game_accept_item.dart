import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';

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
    print("Build Accept Item");

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
    super.build(context);
    return Stack(
      children: [
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
