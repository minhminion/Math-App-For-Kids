import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:provider/provider.dart';

class GameOptionItem extends StatefulWidget {
  GameOptionItem(
      {Key key,
      this.size = 100.0,
      this.text,
      this.color,
      this.isDisable = false,
      this.isDragging = false})
      : super(key: key);

  final double size;
  final Text text;
  final bool isDisable;
  final bool isDragging;
  final Color color;

  factory GameOptionItem.option(
      {Key key,
      double size = 100.0,
      @required int value,
      Color color,
      bool isDisable = false,
      bool isDragging = false}) {
    return GameOptionItem(
      key: key,
      size: size,
      color: color,
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
          margin: EdgeInsets.all(AppConstant.defaultSpacing),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
              color: widget.isDisable
                  ? Colors.grey
                  : widget.color ?? appTheme.primaryColor,
              border: Border.all(color: Colors.white60, width: 4),
              borderRadius:
                  BorderRadius.circular(AppConstant.defaultSpacing * 4.6)),
          child: Stack(
            children: [
              Material(
                color: Colors.transparent,
                child: Center(
                    child: gameType == GameType.comparasionGame
                        ? getCompareString(widget.text.data)
                        : widget.text),
              ),
              Image(image: AssetImage(appTheme.assets.glassButton))
            ],
          )),
    );
  }

  Widget getCompareString(String type) {
    String text = "";
    if (type != "?") {
      ComparasionGameOption _compareGameOption =
          ComparasionGameOption.values[int.parse(type)];
      switch (_compareGameOption) {
        case ComparasionGameOption.greater:
          text = ">";
          break;
        case ComparasionGameOption.equal:
          text = "=";
          break;
        case ComparasionGameOption.less:
          text = "<";
          break;
        default:
          text = "?";
          break;
      }
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: 40.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
