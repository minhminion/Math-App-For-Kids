import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_sounds.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ClickButton extends StatefulWidget {
  final double buttonWidth;
  final double buttonHeight;
  double elevatorHeight;
  final Color buttonColor;
  final Color elevatorColor;
  final Widget child;
  final Function onClick;

  ClickButton(
      {Key key,
      this.onClick,
      this.buttonWidth = 100,
      this.buttonHeight = 100,
      this.buttonColor,
      this.elevatorColor,
      this.child,
      int elevator = 2})
      : super(key: key) {
    elevatorHeight = AppConstant.defaultSpacing * elevator;
  }

  @override
  _ClickButtonState createState() => _ClickButtonState();
}

class _ClickButtonState extends State<ClickButton> {
  Curve _curve = Curves.ease;
  Duration _duration = Duration(milliseconds: 100);
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.buttonWidth,
      height: widget.buttonHeight,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isPressed = true;
          });
          context
              .read<AudioProvider>()
              .playAudio(AudioType.fx, AppSounds.fxSuctionPop);
        },
        onTapUp: (_) {
          setState(() {
            isPressed = false;
          });

          if (widget.onClick != null) Timer(_duration, widget.onClick);
        },
        onTapCancel: () {
          setState(() {
            isPressed = false;
          });
        },
        child: Stack(
          children: [
            Container(
              height: widget.buttonHeight,
              width: widget.buttonWidth,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: widget.buttonHeight - widget.elevatorHeight,
                width: widget.buttonWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.elevatorHeight),
                    color: widget.elevatorColor ?? Colors.blue[700]),
              ),
            ),
            AnimatedPositioned(
              bottom: isPressed ? 0 : widget.elevatorHeight,
              duration: _duration,
              curve: _curve,
              child: Container(
                height: widget.buttonHeight - widget.elevatorHeight,
                width: widget.buttonWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.elevatorHeight),
                    color: widget.buttonColor ?? Colors.blue[500]),
                child: widget.child ??
                    Icon(
                      Icons.play_arrow,
                      size: 70.0,
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
