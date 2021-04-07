import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';

// ignore: must_be_immutable
class BubbleChat extends StatefulWidget {
  String text;

  BubbleChat({Key key, this.text}) : super(key: key);

  @override
  _BubbleChatState createState() => _BubbleChatState();
}

class _BubbleChatState extends BaseStateful<BubbleChat>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _animation = Tween<Offset>(
      begin: Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.8, curve: Curves.elasticInOut),
      ),
    );

    playAnimation();
  }

  void playAnimation() async {
    if (_controller != null) {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SlideTransition(
      position: _animation,
      child: ClipPath(
        clipper: BubbleClipPath(),
        child: Container(
          padding: EdgeInsets.fromLTRB(16.0, 10.0, 15.0, 16.0),
          width: 170,
          height: 90,
          color: Colors.white60,
          child: Text(
            widget.text,
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
