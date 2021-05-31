import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class WFloatingButton extends BaseStateless {
  String heroTag;
  Function onPressed;
  Icon icon;

  WFloatingButton({this.heroTag, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: 60.0,
      height: 60.0,
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: () =>
            onPressed != null ? onPressed() : Navigator.of(context).pop(),
        backgroundColor: appTheme.primaryColor,
        child: icon ??
            Icon(
              Icons.arrow_back,
              size: 40,
            ),
      ),
    );
  }
}
