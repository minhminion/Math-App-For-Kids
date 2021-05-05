import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class WProgessCircular extends BaseStateless {
  final double size;
  final double progessPercent;
  final Widget child;
  final double borderWidth;

  WProgessCircular(
      {Key key,
      @required this.progessPercent,
      this.size = 100,
      this.child,
      this.borderWidth = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      height: size,
      width: size,
      // color: appTheme.primaryColor,
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
                colors: [appTheme.primaryColor, Colors.grey.withAlpha(55)],
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
              width: size - borderWidth,
              height: size - borderWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF333366),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.warningColor.withOpacity(0.5),
                    blurRadius: 7,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
