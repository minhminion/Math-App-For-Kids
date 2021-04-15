import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/game/widgets/shape_game/shape_game_accept_item.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:provider/provider.dart';

class ShapeGameAnswerPlace extends StatefulWidget {
  @override
  _ShapeGameAnswerPlaceState createState() => _ShapeGameAnswerPlaceState();
}

class _ShapeGameAnswerPlaceState extends BaseStateful<ShapeGameAnswerPlace> {
  GameProvider _gameProvider;
  ShapeGame _gameData;
  ShapeGameItem _currentAcceptItem;

  @override
  void initDependencies(BuildContext context) {
    // TODO: implement initDependencies
    super.initDependencies(context);
    _gameProvider = context.provider<GameProvider>();
    _gameData = _gameProvider.game as ShapeGame;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border:
                  Border.all(color: appTheme.cardBackgroundColor, width: 8)),
        ),
        Container(
          width: 200,
          height: 200,
          // alignment: Alignment.center,
          margin: EdgeInsets.only(right: 16),
          child: DragTarget<ShapeGameItem>(
            onAccept: (data) {
              _gameProvider.checkResult(data);
            },
            onWillAccept: (data) {
              return data.shapeType == ShapeType.values[_gameData.result];
            },
            builder:
                (context, List<ShapeGameItem> candidateData, rejectedData) {
              List<ShapeGameItem> listItem = _gameData.listAcceptItem;
              if (listItem.length > 0 &&
                  _currentAcceptItem != listItem[listItem.length - 1]) {
                _currentAcceptItem = listItem[listItem.length - 1];
                return ShapeGameAcceptItem(
                    imageUrl: _currentAcceptItem.imageUrl);
              } else {
                return null;
              }
              // if (isSuccess) {
              //   return ShapeGameAcceptItem(
              //     animationCotroller: _controller,
              //   );
              // } else {
              //   return null;
              // }
            },
          ),
        ),
      ],
    );
  }
}
