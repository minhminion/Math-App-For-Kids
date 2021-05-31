import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/lesson/lesson_list_page_body.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:math_app_for_kid/utils/app_theme.dart';
import 'package:math_app_for_kid/widgets/w_floating_button.dart';

class LessonListPage extends StatefulWidget {
  @override
  _LessonListPageState createState() => _LessonListPageState();
}

class _LessonListPageState extends State<LessonListPage> {
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
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(appTheme.assets.backgroundLanding_2),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            LessonListPageBody(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 28, top: 16),
        child: Row(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WFloatingButton(),
            WFloatingButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.settingsRoute);
              },
            ),
            // SizedBox(
            //   height: 16,
            // ),
          ],
        ),
      ),
    );
  }
}
