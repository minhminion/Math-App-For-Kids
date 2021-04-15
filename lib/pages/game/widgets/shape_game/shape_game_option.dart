import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:provider/provider.dart';

class ShapeGameOption extends StatefulWidget {
  @override
  _ShapeGameOptionState createState() => _ShapeGameOptionState();
}

class _ShapeGameOptionState extends BaseStateful<ShapeGameOption> {
  ShapeGame _gameData;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _gameData = context.watch<GameProvider>().game as ShapeGame;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      int crossAxisCount = 3;
      double childAspectRatio =
          (constraints.maxWidth * 3) / (3 * constraints.maxHeight);
      return GridView.count(
        shrinkWrap: true,
        primary: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        children: _buildListOption(),
      );
    });
  }

  List<Widget> _buildListOption() {
    List<Widget> list = [];

    for (ShapeGameItem item in _gameData.items) {
      if (_gameData.listAcceptItem.contains(item)) {
        list.add(Container(
          width: double.infinity,
          height: double.infinity,
        ));
      } else {
        list.add(Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          // color: Colors.blue,
          child: Draggable<ShapeGameItem>(
            data: item,
            feedback: _getItemShape(item.imageUrl),
            childWhenDragging: Container(),
            child: _getItemShape(item.imageUrl),
          ),
        ));
      }
    }

    return list;
  }

  Widget _getItemShape(String imageUrl) {
    return Image(width: 80, image: AssetImage(imageUrl));
  }
}

class DrawTriangleShape extends CustomPainter {
  Paint painter;

  DrawTriangleShape() {
    painter = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
