import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:provider/provider.dart';

class ShapeGameOption extends StatefulWidget {
  ShapeGameOption(Key key) : super(key: key);

  @override
  _ShapeGameOptionState createState() => _ShapeGameOptionState();
}

class _ShapeGameOptionState extends BaseStateful<ShapeGameOption>
    with TickerProviderStateMixin {
  ShapeGame gameData;

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    gameData = context.watch<GameProvider>().game as ShapeGame;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(ShapeGameOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.key != widget.key) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
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
        children: _buildListOption(gameData.items),
      );
    });
  }

  List<Widget> _buildListOption(List<ShapeGameItem> items) {
    List<Widget> list = [];

    for (ShapeGameItem item in items) {
      if (gameData.listAcceptItem.contains(item)) {
        list.add(Container(
          width: double.infinity,
          height: double.infinity,
        ));
      } else {
        list.add(Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
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
    return ScaleTransition(
        scale: _animation,
        child: Image(width: 90, image: AssetImage(imageUrl)));
  }
}
