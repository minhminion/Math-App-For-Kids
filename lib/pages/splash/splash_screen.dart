import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateToLanding() {
    Navigator.pushReplacementNamed(context, AppRoute.routeLanding);
  }

  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, () => navigateToLanding());
  }

  fetchAllLesson() async {
    await context.provider<LessonProvider>().fetchAllLesson();
    startTime();
  }

  @override
  void initState() {
    super.initState();
    fetchAllLesson();
    // startTime();
  }

  @override
  Widget build(BuildContext context) {
    final riveArtboard = context.watch<CharacterProvider>().riveArtboard;

    return Scaffold(
      backgroundColor: context.appTheme().backgroundColor,
      body: Center(
        child: SizedBox(
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
      ),
    );
  }
}
