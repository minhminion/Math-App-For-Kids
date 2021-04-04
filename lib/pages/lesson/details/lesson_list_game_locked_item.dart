import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';

class LockedGameItem extends StatefulWidget {
  LockedGameItem({Key key, @required this.gamePlay}) : super(key: key);

  final GamePlay gamePlay;

  @override
  _LockedGameItemState createState() => _LockedGameItemState();
}

class _LockedGameItemState extends BaseStateful<LockedGameItem>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initDependencies(BuildContext context) {
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);

    _animation = Tween(begin: 0.0, end: 40.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.100, 0.700, curve: Curves.easeInExpo)));

    super.initDependencies(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => {_playAnimation()},
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
            width: 300,
            decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.white, width: 4),
                borderRadius:
                    BorderRadius.circular(AppConstant.defaultSpacing)),
          ),
          AnimatedBuilder(
              animation: _controller.view,
              builder: (context, child) {
                return Container(
                  height: 80 + _animation.value,
                  width: 80 + _animation.value,
                  decoration: BoxDecoration(
                      color: appTheme.errorColor,
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Center(
                      child: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 40 + _animation.value,
                  )),
                );
              }),
        ],
      ),
    );
  }
}
