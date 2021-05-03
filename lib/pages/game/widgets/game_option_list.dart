import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/game_option_item.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_sounds.dart';
import 'package:provider/provider.dart';

class OptionItem {
  OptionItem(this.value, this.color) : super();

  int value;
  Color color;
}

class GameOptionList extends StatefulWidget {
  GameOptionList({Key key}) : super(key: key);

  @override
  _GameOptionListState createState() => _GameOptionListState();
}

class _GameOptionListState extends BaseStateful<GameOptionList> {
  Game _gameData;
  List<Color> _colors = [];

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);

    _gameData = context.watch<GameProvider>().game;
  }

  @override
  void initState() {
    super.initState();
    _colors.add(Colors.red);
    _colors.add(Colors.green);
    _colors.add(Colors.orange[800]);
    _colors.shuffle();
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
          children: _getGameOptions(_gameData)
              .asMap()
              .entries
              .map<Widget>(_buildOptionItem)
              .toList(),
        ));
  }

  Widget _buildOptionItem(MapEntry<int, int> entry) {
    int option = entry.value;
    int index = entry.key;
    if (!context.watch<GameProvider>().isComplete ||
        option != _gameData.result) {
      return context.watch<GameProvider>().rejecteds.contains(option)
          ? GameOptionItem.option(
              value: option,
              isDisable: true,
            )
          : Draggable<OptionItem>(
              data: OptionItem(option, _colors[index]),
              onDragStarted: () {
                context
                    .read<CharacterProvider>()
                    .changeAnimation(CharacterType.talk);
                context
                    .read<AudioProvider>()
                    .playAudio(AudioType.fx, AppSounds.fxBubbleBlip);
                return;
              },
              onDraggableCanceled: (_, __) {
                context
                    .read<CharacterProvider>()
                    .changeAnimation(CharacterType.idle);
                context
                    .read<AudioProvider>()
                    .playAudio(AudioType.fx, AppSounds.fxBubbleBlip);
                return;
              },
              child: GameOptionItem.option(
                value: option,
                color: _colors[index],
              ),
              feedback: GameOptionItem.option(
                value: option,
                isDragging: true,
                color: _colors[index],
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

  List<int> _getGameOptions(Game game) {
    switch (game.gameType) {
      case GameType.countingGame:
        return (game as CountingGame).options;
      case GameType.comparasionGame:
        return (game as ComparasionGame).options;
        break;
      case GameType.additionAndSubtractionGame:
        return (game as AdditionAndSubtractionGame).options;
      default:
        return [];
    }
  }
}
