import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';

class WButtonIcon extends StatelessWidget {
  const WButtonIcon(
      {Key key, @required this.onPressed, this.color, this.text, this.icon})
      : super(key: key);

  final Function() onPressed;
  final Text text;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon ??
          Icon(
            Icons.play_arrow,
            size: 40,
          ),
      label: text ??
          Text(
            "Start",
            style: TextStyle(fontSize: 20),
          ),
      style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
          borderRadius:
              new BorderRadius.circular(AppConstant.defaultSpacing * 4),
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
        primary: color ?? Colors.green,
      ),
    );
  }
}
