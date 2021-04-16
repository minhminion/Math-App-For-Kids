import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_item.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:provider/provider.dart';

class GameOptionList extends StatefulWidget {
  GameOptionList({Key key}) : super(key: key);

  @override
  _GameOptionListState createState() => _GameOptionListState();
}

class _GameOptionListState extends BaseStateful<GameOptionList> {
  GamePlay _gameData;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _gameData = context.watch<GameProvider>().game;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        width: 150,
        margin: EdgeInsets.fromLTRB(0, 16, 16, 16),
        decoration: BoxDecoration(
            color: appTheme.cardBackgroundColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _gameData.options.map<Widget>(_buildOptionItem).toList(),
        ));
  }

  Widget _buildOptionItem(int option) {
    if (!context.watch<GameProvider>().isComplete ||
        option != _gameData.result) {
      return context.watch<GameProvider>().rejecteds.contains(option)
          ? GameOptionItem.option(
              value: option,
              isDisable: true,
            )
          : Draggable<int>(
              data: option,
              child: GameOptionItem.option(
                value: option,
              ),
              feedback: GameOptionItem.option(
                value: option,
                isDragging: true,
              ),
              childWhenDragging: _buildEmptyOption(),
            );
    }
    return _buildEmptyOption();
  }

  Widget _buildEmptyOption() {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
