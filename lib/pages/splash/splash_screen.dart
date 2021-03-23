import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/utils/app_assets.dart';
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
  void loadRiveFile() async {
    final bytes = await rootBundle.load(AppAssets.origin().characterRiv);
    final file = RiveFile();
    if (file.import(bytes)) {
      context.provider<CharacterProvider>().setRive(file);
      startTime();
    }
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration,
        () => Navigator.pushReplacementNamed(context, AppRoute.routeLanding));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadRiveFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final riveArtboard = context.watch<CharacterProvider>().riveArtboard;

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
