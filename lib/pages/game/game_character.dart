import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class GameCharacter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final riveArtboard = context.watch<CharacterProvider>().riveArtboard;

    return Container(
      width: 200,
      // color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: AppConstant.defaultSpacing * 4),
      child: Material(
        color: Colors.transparent,
        child: riveArtboard == null
            ? const SizedBox()
            : Rive(
                artboard: riveArtboard,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
