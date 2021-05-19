import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class SplashScreen2 extends BaseStateless {
  startTime(context) async {
    var duration = new Duration(seconds: 3);
    return new Timer(
        duration,
        () => Navigator.pushNamedAndRemoveUntil(
            context, AppRoute.routeLanding, (_) => false));
  }

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    startTime(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final riveArtboard = context.watch<CharacterProvider>().riveArtboard;
    return Scaffold(
      backgroundColor: context.appTheme().backgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 300 / 2),
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "MK'S Studio",
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 300,
            height: 300,
            width: 200,
            child: Hero(
              tag: "character",
              child: Material(
                color: Colors.transparent,
                child: riveArtboard == null
                    ? const SizedBox()
                    : Rive(
                        artboard: riveArtboard,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ),
          // Container(child: Text("M&D Studio")),
        ],
      ),
    );
  }
}
