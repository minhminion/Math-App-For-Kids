import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/bubble.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_board.dart';
import 'package:math_app_for_kid/pages/game/widgets/common/game_bubble.dart';
import 'package:math_app_for_kid/pages/game/widgets/common/game_character.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_list.dart';
import 'package:math_app_for_kid/pages/game/widgets/shape_game/shape_game_board.dart';
import 'package:math_app_for_kid/pages/lesson/details/lesson_item_dialog.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/widgets/r_hero_dialog_router.dart';
import 'package:math_app_for_kid/widgets/w_floating_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GamePlayPage extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    GameProvider _gameProvider = context.provider<GameProvider>();
    return Scaffold(
        key: ValueKey(_gameProvider.currentGameIndex + 1),
        backgroundColor: appTheme.backgroundColor,
        floatingActionButton: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -28,
              top: 8,
              height: 80,
              child: WFloatingButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      HeroDialogRoute(
                        builder: (BuildContext context) => LessonItemDialog(
                          game: _gameProvider.game,
                          gameIndex: _gameProvider.currentGameIndex + 1,
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(appTheme.assets.backgroundLanding_2))),
            child: _buildGameContent(_gameProvider.game.gameType)));
  }

  Widget _buildGameContent(GameType gameType) {
    if (gameType == GameType.shapeGame) {
      return ShapeGameBoard();
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          GameOptionList(),

          // Game Board
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  0,
                  AppConstant.defaultSpacing * 2,
                  AppConstant.defaultSpacing * 4,
                  AppConstant.defaultSpacing * 2),
              child: GameBoard(),
            ),
          ),
          // Game Option
          Container(
            padding: EdgeInsets.all(AppConstant.defaultSpacing * 2),
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(
                  flex: 2,
                ),
                Selector<CharacterProvider, Bubble>(
                  selector: (_, _charaterProvider) => _charaterProvider.bubble,
                  builder: (_, bubble, __) => Material(
                    color: Colors.transparent,
                    child: GameBubble(bubbleType: bubble.type),
                  ),
                ),
                Flexible(flex: 4, child: GameCharacter()),
              ],
            ),
          ),
        ]);
  }
}
