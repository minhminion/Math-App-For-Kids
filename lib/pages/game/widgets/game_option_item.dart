import 'package:flutter/material.dart';

class GameOptionItem extends StatelessWidget {
  const GameOptionItem({Key key, this.size = 100.0, this.text})
      : super(key: key);

  factory GameOptionItem.option(
      {Key key, double size = 100.0, @required int value}) {
    return GameOptionItem(
      key: key,
      size: size,
      text: Text(value.toString()),
    );
  }

  final double size;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(8.0)),
        child: Material(
          color: Colors.transparent,
          child: Center(child: text),
        ));
  }
}
