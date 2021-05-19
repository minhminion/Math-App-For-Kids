import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/achievements/achievements_content.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:math_app_for_kid/widgets/w_floating_button.dart';

// ignore: must_be_immutable
class AchievementsPage extends BaseStateless {
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                  margin: EdgeInsets.all(AppConstant.defaultSpacing * 4),
                  padding: EdgeInsets.all(AppConstant.defaultSpacing * 2),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: appTheme.cardBackgroundColor,
                      borderRadius:
                          BorderRadius.circular(AppConstant.defaultSpacing)),
                  child: AchievementsContent()),
              Positioned(
                  bottom: 0,
                  left: 8,
                  height: 250,
                  child: Image(
                      image: AssetImage(appTheme.assets.characterWithCrown))),
            ],
          )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // WFloatingButton(
          //   icon: Icon(Icons.settings),
          //   onPressed: () {
          //     Navigator.pushNamed(context, AppRoute.settingsRoute);
          //   },
          // ),
          // SizedBox(
          //   height: 16,
          // ),
          WFloatingButton(),
        ],
      ),
    );
  }
}
