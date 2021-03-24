import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:math_app_for_kid/widgets/w_button_icon.dart';
import 'package:rive/rive.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends BaseStateful<LandingPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Artboard riveArtboard =
        context.provider<CharacterProvider>().riveArtboard;

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.defaultSpacing),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Hero(
              tag: "character",
              child: Material(
                child: Container(
                  height: 200,
                  width: 150,
                  color: appTheme.backgroundColor,
                  child: riveArtboard == null
                      ? const SizedBox()
                      : Rive(artboard: riveArtboard, fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(
              width: 200.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WButtonIcon(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoute.lessonRoute),
                  color: appTheme.successColor,
                  text: Text("Start", style: TextStyle(fontSize: 20)),
                  icon: Icon(
                    Icons.play_arrow,
                    size: 40,
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
