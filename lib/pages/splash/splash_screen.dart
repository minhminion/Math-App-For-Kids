import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration,
        () => Navigator.pushReplacementNamed(context, AppRoute.routeLanding));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.provider<CharacterProvider>().loadRiveFile();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    final Artboard riveArtboard =
        context.provider<CharacterProvider>().riveArtboard;

    return Scaffold(
      body: Center(
        child: Hero(
          tag: "character",
          child: Material(
            child: Container(
              height: 300,
              child: riveArtboard == null
                  ? const SizedBox()
                  : Rive(
                      artboard: riveArtboard,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
