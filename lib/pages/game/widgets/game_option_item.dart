import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:provider/provider.dart';

class GameOptionItem extends StatefulWidget {
  GameOptionItem(
      {Key key,
      this.size = 100.0,
      this.text,
      this.isDisable = false,
      this.isDragging = false})
      : super(key: key);

  final double size;
  final Text text;
  final bool isDisable;
  final bool isDragging;

  factory GameOptionItem.option(
      {Key key,
      double size = 100.0,
      @required int value,
      bool isDisable = false,
      bool isDragging = false}) {
    return GameOptionItem(
      key: key,
      size: size,
      isDragging: isDragging,
      text: Text(
        value.toString(),
        style: TextStyle(
          fontSize: 40.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      isDisable: isDisable,
    );
  }

  @override
  _GameOptionItemState createState() => _GameOptionItemState();
}

class _GameOptionItemState extends BaseStateful<GameOptionItem>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.95)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.isDragging == true) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    GameType gameType = context.read<GameProvider>().game.gameType;
    return ScaleTransition(
      scale: _animation,
      child: Container(
          margin: EdgeInsets.all(8.0),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
              color: widget.isDisable ? Colors.grey : appTheme.successColor,
              borderRadius: BorderRadius.circular(8.0)),
          child: Material(
            color: Colors.transparent,
            child: Center(
                child: gameType == GameType.comparasionGame
                    ? getCompareString(widget.text.data)
                    : widget.text),
          )),
    );
  }

  Widget getCompareString(String type) {
    if (type != "?") {
      ComparasionGameOption _compareGameOption =
          ComparasionGameOption.values[int.parse(type)];
      switch (_compareGameOption) {
        case ComparasionGameOption.greater:
          return Text(">");
        case ComparasionGameOption.equal:
          return Text("=");
        case ComparasionGameOption.less:
          return Text("<");
        default:
          return Text("?");
      }
    }
    return Text("?");
  }
}
