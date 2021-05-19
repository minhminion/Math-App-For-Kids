import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:math_app_for_kid/widgets/w_click_button.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends BaseStateful<LandingPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                image: AssetImage(appTheme.assets.backgroundLanding_1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClickButton(
                buttonHeight: 100,
                buttonWidth: 200,
                // buttonColor: Color(0xFFFFCC00),
                // elevatorColor: Color(0xFFFF9700),
                onClick: () =>
                    Navigator.pushNamed(context, AppRoute.lessonRoute),
                child: Icon(
                  Icons.play_arrow,
                  size: 60,
                  color: Colors.white,
                )),
            SizedBox(width: 16),
            ClickButton(
                buttonHeight: 100,
                buttonWidth: 100,
                buttonColor: Color(0xFFFFCC00),
                elevatorColor: Color(0xFFFF9700),
                onClick: () =>
                    Navigator.pushNamed(context, AppRoute.achievementsRoute),
                child: Icon(
                  Icons.emoji_events,
                  size: 60,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
