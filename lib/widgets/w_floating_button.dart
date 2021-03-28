import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class WFloatingButton extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: 60.0,
      height: 60.0,
      child: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        backgroundColor: appTheme.successColor,
        child: Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}
