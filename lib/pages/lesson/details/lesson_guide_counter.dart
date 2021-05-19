import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_sounds.dart';

class LessonGuideCounter extends StatefulWidget {
  final CarouselController carouselController;

  LessonGuideCounter({Key key, this.carouselController}) : super(key: key);

  @override
  _LessonGuideCounterState createState() => _LessonGuideCounterState();
}

class _LessonGuideCounterState extends BaseStateful<LessonGuideCounter>
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
    return _buildCounter();
  }

  Widget _buildGuideContent(int value) {
    int number = value * 2;
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_buildGuideItem(number - 1), _buildGuideItem(number)]);
  }

  Widget _buildGuideItem(int number) {
    double size = number > 7 ? 35 : 50.0;

    List<Widget> _listImage = [];
    for (int i = 0; i < number; i++) {
      _listImage.add(
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: AppConstant.defaultSpacing / 4),
            width: size,
            height: size,
            child: Image(image: AssetImage(appTheme.assets.planet(1)))),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              child: Text(
                number.toString(),
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            ..._listImage.toList()
          ],
        ),
        ClipOval(
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
                    AudioType.voice, AppSounds.numberVoice(number));
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCounter() {
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
                items: [1, 2, 3, 4, 5].map((value) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: AppConstant.defaultSpacing,
                              vertical: AppConstant.defaultSpacing),
                          padding: EdgeInsets.symmetric(
                              horizontal: AppConstant.defaultSpacing * 8,
                              vertical: AppConstant.defaultSpacing * 2),
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
                children: [1, 2, 3, 4, 5].map((value) {
                  int index = [1, 2, 3, 4, 5].indexOf(value);
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
