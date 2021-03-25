import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_route.dart';

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
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Image.asset(
            appTheme.assets.backgroundLanding,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () =>
                      // Navigator.pushNamed(context, AppRoute.lessonRoute),
                      Navigator.pushNamed(context, AppRoute.testRoute),
                  child: Icon(
                    Icons.settings,
                    size: 70.0,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(
                          AppConstant.defaultSpacing * 2),
                    ),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    primary: appTheme.successColor,
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoute.lessonRoute),
                  // Navigator.pushNamed(context, AppRoute.testRoute),
                  child: Icon(
                    Icons.play_arrow,
                    size: 70.0,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(
                          AppConstant.defaultSpacing * 2),
                    ),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    primary: appTheme.successColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
