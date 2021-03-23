import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:rive/rive.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    context
        .provider<CharacterProvider>()
        .changeAnimation(CharacterType.success);
  }

  @override
  Widget build(BuildContext context) {
    final Artboard riveArtboard =
        context.provider<CharacterProvider>().riveArtboard;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Hero(
              tag: "character",
              child: Material(
                child: Container(
                  height: 200,
                  width: 300,
                  child: riveArtboard == null
                      ? const SizedBox()
                      : Rive(artboard: riveArtboard, fit: BoxFit.contain),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoute.routeHome),
                    child: Text("Start")),
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
}
