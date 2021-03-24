import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/utils/app_assets.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:math_app_for_kid/utils/app_theme.dart';
import 'package:math_app_for_kid/widgets/w_button_icon.dart';
import 'package:rive/rive.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  AppTheme appTheme;

  @override
  void initState() {
    super.initState();
    setState(() {
      appTheme = context.appTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  width: 200,
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
                      Navigator.pushNamed(context, AppRoute.routeHome),
                  color: appTheme.successColor,
                  text: Text("Start", style: TextStyle(fontSize: 20)),
                  icon: Icon(
                    Icons.play_arrow,
                    size: 40,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoute.lessonRoute),
                    child: Text("Settings"))
              ],
            )
          ]),
        ),
      ),
    );
  }

  ElevatedButton _buildStartButton() {
    return ElevatedButton.icon(
      onPressed: () => Navigator.pushNamed(context, AppRoute.routeHome),
      icon: Icon(
        Icons.play_arrow,
        size: 40,
      ),
      label: Text(
        "Start",
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
          borderRadius:
              new BorderRadius.circular(AppConstant.defaultSpacing * 4),
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
        primary: appTheme.successColor,
      ),
    );
  }
}
