import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class BubbleChat extends BaseStateless {
  final String text;

  BubbleChat({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ClipPath(
      clipper: BubbleClipPath(),
      child: Container(
        padding: EdgeInsets.all(15.0),
        width: 170,
        height: 90,
        color: Colors.white60,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: appTheme.assets.fontRoboto,
            color: Colors.black,
            fontSize: 20.0,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class BubbleClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, size.height - 40.0)
      ..quadraticBezierTo(0, size.height - 20.0, 15.0, size.height - 20.0)
      ..lineTo(15.0, size.height - 20.0)
      ..lineTo(30.0, size.height - 5)
      ..lineTo(30.0, size.height - 20.0)
      ..lineTo(size.width - 20.0, size.height - 20.0)
      ..quadraticBezierTo(
          size.width, size.height - 20.0, size.width, size.height - (20.0 * 2))
      ..lineTo(size.width, 20.0)
      ..quadraticBezierTo(size.width, 0, size.width - 20.0, 0)
      ..lineTo(20.0, 0)
      ..quadraticBezierTo(0, 0, 0, 20.0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
