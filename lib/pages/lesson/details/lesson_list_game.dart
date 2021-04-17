import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_item_dialog.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_list_game_locked_item.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/widgets/r_hero_dialog_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LessonListGames extends StatefulWidget {
  LessonListGames({Key key, this.lesson}) : super(key: key);

  final Lesson lesson;

  @override
  _LessonListGamesState createState() => _LessonListGamesState();
}

class _LessonListGamesState extends BaseStateful<LessonListGames>
    with TickerProviderStateMixin {
  final _scrollDirection = Axis.horizontal;
  List<Game> gamePlays;

  AnimationController _controller;
  Animation<double> _animation;
  Duration _animtionDuration = Duration(milliseconds: 800);

  ItemScrollController _itemScrollController;
  ItemPositionsListener _itemPositionsListener;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _controller = AnimationController(vsync: this, duration: _animtionDuration);

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)),
    );

    _itemScrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();

    gamePlays = widget.lesson.games;

    _controller.forward(from: 0.0);
  }

  @override
  void afterFirstBuild(BuildContext context) {
    super.afterFirstBuild(context);
    if (gamePlays != null && gamePlays.length > 3) {
      scrollTo(widget.lesson.completedGame);
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
    gamePlays = widget.lesson.games;
    if (gamePlays == null || gamePlays.length == 0)
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
      child: ScrollablePositionedList.builder(
          padding: EdgeInsets.fromLTRB(8.0, 160, 8.0, 32.0),
          scrollDirection: _scrollDirection,
          itemPositionsListener: _itemPositionsListener,
          itemScrollController: _itemScrollController,
          itemCount: gamePlays.length,
          itemBuilder: (context, index) => index > widget.lesson.completedGame
              ? LockedGameItem(
                  key: Key(index.toString()), gamePlay: gamePlays[index])
              : _buildLessonContentItem(gamePlays[index], index + 1,
                  index == widget.lesson.completedGame)),
    );
  }

  Widget _buildLessonContentItem(Game game, int index, bool isCurrentGame) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppConstant.defaultSpacing),
      onTap: () => openGameDialog(game, index),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: "game_item_${game.id}",
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              width: 300,
              decoration: BoxDecoration(
                  // Color grey: IsCompleted, blueAccent: IsCurrentGame
                  // ecoration: BoxDecoration(
                  color: isCurrentGame ? Colors.blueAccent : Colors.grey,
                  border: Border.all(color: Colors.white, width: 4),
                  borderRadius:
                      BorderRadius.circular(AppConstant.defaultSpacing)),
            ),
          ),
          Hero(
            tag: "game_item_index_${game.id}",
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: appTheme.errorColor,
                  border: Border.all(color: Colors.white, width: 4),
                  borderRadius: BorderRadius.all(Radius.circular(80))),
              child: Center(
                child: Text(
                  index.toString(),
                  style: TextStyle(
                    fontFamily: appTheme.assets.fontRoboto,
                    color: Colors.white,
                    fontSize: 30.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          if (!isCurrentGame)
            Positioned(
              right: AppConstant.defaultSpacing * 2,
              top: 0,
              child: Hero(
                tag: "game_item_trophy_${game.id}",
                child: Image(
                  image: AssetImage(appTheme.assets.gameTrophy),
                  height: AppConstant.defaultSpacing * 8,
                  width: AppConstant.defaultSpacing * 8,
                ),
              ),
            ),
          Positioned(
            top: 0,
            right: 0,
            child: Hero(
              tag: "game_item_closebtn_${game.id}",
              child: Container(),
            ),
          )
        ],
      ),
    );
  }

  void scrollTo(int index) {
    _itemScrollController.jumpTo(index: index, alignment: 0);
  }

  void openGameDialog(Game game, int index) {
    Navigator.push(
        context,
        HeroDialogRoute(
            builder: (BuildContext context) => Center(
                  child: LessonItemDialog(
                    game: game,
                    gameIndex: index,
                  ),
                )));
  }
}
