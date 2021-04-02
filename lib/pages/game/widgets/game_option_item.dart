import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class GameOptionItem extends BaseStateless {
  GameOptionItem(
      {Key key, this.size = 100.0, this.text, this.isDisable = false})
      : super(key: key);

  factory GameOptionItem.option(
      {Key key,
      double size = 100.0,
      @required int value,
      bool isDisable = false}) {
    return GameOptionItem(
      key: key,
      size: size,
      text: Text(value.toString()),
      isDisable: isDisable,
    );
  }

  final double size;
  final Text text;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: EdgeInsets.all(8.0),
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: isDisable ? Colors.grey : appTheme.successColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: Material(
          color: Colors.transparent,
          child: Center(child: text),
        ));
  }
}
