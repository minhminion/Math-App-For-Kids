import 'dart:math' as math;

import 'package:flutter/material.dart';

class LessonSpaceBar extends StatelessWidget {
  const LessonSpaceBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0) as double;
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Stack(
          children: [
            Center(
              child: Opacity(
                  opacity: 1 - opacity,
                  child: getTitle(
                    'Bài học',
                  )),
            ),
            Opacity(
              opacity: opacity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  getImage(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getImage() {
    return Container(
      width: double.infinity,
      child: Image(
        image: AssetImage('assets/base/images/lesson/bg_appbar_1.png'),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  Widget getTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
