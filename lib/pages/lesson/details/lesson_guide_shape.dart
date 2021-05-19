import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_sounds.dart';
import 'package:math_app_for_kid/widgets/w_draw_triangle.dart';

class LessonGuideShape extends StatefulWidget {
  final CarouselController carouselController;

  LessonGuideShape({Key key, this.carouselController}) : super(key: key);

  @override
  _LessonGuideShapeState createState() => _LessonGuideShapeState();
}

class _LessonGuideShapeState extends BaseStateful<LessonGuideShape>
    with TickerProviderStateMixin {
  int _current = 0;

  AnimationController _controller;
  Animation<double> _animation;

  AudioProvider _audioProvider;

  @override
  void initState() {
    _audioProvider = context.provider<AudioProvider>();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _animation = CurvedAnimation(
        parent: _controller, curve: Interval(0.5, 1, curve: Curves.easeIn));
    _controller.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.reset();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildShape();
  }

  Widget _buildGuideContent(ShapeType value) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildShapeType(value),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstant.defaultSpacing * 3),
              child: Text("=",
                  style: TextStyle(color: Colors.white, fontSize: 40)),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Image(
                    width: 100,
                    image:
                        AssetImage(appTheme.assets.getShapeImages(value, 1))),
                SizedBox(
                  width: AppConstant.defaultSpacing * 2,
                ),
                Image(
                    width: 100,
                    image:
                        AssetImage(appTheme.assets.getShapeImages(value, 2))),
              ],
            ),
          ],
        ),
        Positioned(
          top: AppConstant.defaultSpacing * 2,
          right: AppConstant.defaultSpacing * 2,
          child: ClipOval(
            child: Material(
              color: Colors.redAccent, // button color
              child: InkWell(
                splashColor: appTheme.warningColor, // inkwell color
                child: SizedBox(
                    width: AppConstant.defaultSpacing * 7,
                    height: AppConstant.defaultSpacing * 7,
                    child: Icon(
                      Icons.volume_up,
                      color: Colors.white,
                      size: 32,
                    )),
                onTap: () {
                  _audioProvider.playAudio(
                      AudioType.voice,
                      AppSounds.getGuideShapeAudio(
                          value.toString().split(".")[1]));
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShapeType(ShapeType shapeType) {
    double size = 150;
    double borderWidth = 4;
    switch (shapeType) {
      case ShapeType.circle:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: appTheme.warningColor,
              border:
                  Border.all(color: appTheme.warningColor, width: borderWidth)),
        );
      case ShapeType.square:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: appTheme.warningColor,
              border:
                  Border.all(color: appTheme.warningColor, width: borderWidth)),
        );
      case ShapeType.rectangle:
        return Container(
          width: size,
          height: size - size / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: appTheme.warningColor,
              border:
                  Border.all(color: appTheme.warningColor, width: borderWidth)),
        );
        break;
      case ShapeType.triangle:
        return CustomPaint(
          size: Size(size, size),
          painter: DrawTriangleShape(
              strokeWidth: borderWidth,
              color: appTheme.warningColor,
              paintingStyle: PaintingStyle.fill),
        );
        break;
    }
    return Container();
  }

  Widget _buildShape() {
    return FadeTransition(
      opacity: _animation,
      child: Stack(
        children: [
          Wrap(
            children: [
              CarouselSlider(
                carouselController: widget.carouselController,
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: ShapeType.values.map((value) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: AppConstant.defaultSpacing,
                              vertical: AppConstant.defaultSpacing),
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: AppConstant.defaultSpacing * 8,
                          //     vertical: AppConstant.defaultSpacing * 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstant.defaultSpacing * 2),
                            color: appTheme.cardBackgroundColor,
                          ),
                          child: _buildGuideContent(value));
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ShapeType.values.map((value) {
                  int index = ShapeType.values.indexOf(value);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? Colors.grey[300] : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
