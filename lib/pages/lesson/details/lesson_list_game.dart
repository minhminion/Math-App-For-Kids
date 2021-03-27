import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_item_dialog.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/widgets/r_hero_dialog_router.dart';
import 'package:provider/provider.dart';

class LessonListGames extends StatefulWidget {
  LessonListGames({Key key, this.data}) : super(key: key);

  final List<BaseGamePlay> data;

  @override
  _LessonListGamesState createState() => _LessonListGamesState();
}

class _LessonListGamesState extends BaseStateful<LessonListGames>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)),
    );

    _controller.forward(from: 0.0);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.data == null || widget.data.length == 0)
      return FadeTransition(
        opacity: _animation,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Text(
              "Hiện tại chưa có game !",
              style: TextStyle(
                fontFamily: appTheme.assets.fontRoboto,
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );

    return FadeTransition(
      opacity: _animation,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.fromLTRB(8.0, 160, 8.0, 32.0),
          itemCount: widget.data.length,
          itemBuilder: (context, index) =>
              index > context.watch<LessonProvider>().lesson.completedGame
                  ? _buildLockedLessonContentItem(widget.data[index])
                  : _buildLessonContentItem(widget.data[index])),
    );
  }

  Widget _buildLessonContentItem(BaseGamePlay game) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppConstant.defaultSpacing),
      onTap: () => openGameDialog(game),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: "game_item_${game.id}",
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius:
                      BorderRadius.circular(AppConstant.defaultSpacing)),
            ),
          ),
          Center(
            child: Text(
              game.id.toString(),
              style: TextStyle(
                fontFamily: appTheme.assets.fontRoboto,
                color: Colors.white,
                fontSize: 30.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedLessonContentItem(BaseGamePlay game) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
          width: 300,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(AppConstant.defaultSpacing)),
        ),
        Center(
          child: Text(
            "Locked",
            style: TextStyle(
              fontFamily: appTheme.assets.fontRoboto,
              color: Colors.white,
              fontSize: 30.0,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void openGameDialog(BaseGamePlay game) {
    Navigator.push(
        context,
        HeroDialogRoute(
            builder: (BuildContext context) => Center(
                  child: LessonItemDialog(
                    game: game,
                  ),
                )));
  }
}
