import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class WProgessCircular extends BaseStateless {
  final double size;
  final double progessPercent;
  final Widget child;

  WProgessCircular(
      {Key key, @required this.progessPercent, this.size = 100, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: size,
      width: size,
      // color: appTheme.successColor,
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return SweepGradient(
                startAngle: 3 * pi / 2,
                endAngle: 7 * pi / 2,
                tileMode: TileMode.repeated,
                center: Alignment.center,
                stops: [progessPercent, progessPercent],
                colors: [appTheme.successColor, Colors.grey.withAlpha(55)],
              ).createShader(rect);
            },
            child: Container(
              width: size,
              height: size,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
          ),
          Center(
            child: Container(
              width: size - 20,
              height: size - 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF333366)),
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
