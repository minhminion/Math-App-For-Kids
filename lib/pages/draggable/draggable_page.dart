import "package:flutter/material.dart";
import 'package:math_app_for_kid/services/safety/base_stateful.dart';

class DraggablePage extends StatefulWidget {
  DraggablePage({Key key}) : super(key: key);

  @override
  _DraggablePageState createState() => _DraggablePageState();
}

class _DraggablePageState extends BaseStateful<DraggablePage> {
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("3 + 2 =", style: TextStyle(fontSize: 30)),
        DragTarget<int>(onAccept: (value) {
          setState(() {
            isComplete = value == 5;
          });
        }, builder: (context, candicates, reject) {
          return isComplete ? _buildOptionBox("5") : _buildOptionBox("?", true);
        }),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Draggable<int>(
                data: 1,
                child: _buildOptionBox("1"),
                childWhenDragging: _buildOptionBox("1", true),
                feedback: _buildOptionBox("1")),
            Draggable<int>(
                data: 2,
                child: _buildOptionBox("2"),
                childWhenDragging: _buildOptionBox("2", true),
                feedback: _buildOptionBox("2")),
            Draggable<int>(
                data: 5,
                child: _buildOptionBox("5"),
                childWhenDragging: _buildOptionBox("5", true),
                feedback: _buildOptionBox("5")),
          ],
        )
      ],
    ));
  }

  Container _buildOptionBox(String text, [bool disable = false]) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: !disable ? Colors.blueAccent : Colors.black26,
          borderRadius: BorderRadius.circular(40)),
      child: Text(text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            decoration: TextDecoration.none,
          )),
    );
  }
}
