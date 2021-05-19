import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_sounds.dart';

class LessonGuideCompare extends StatefulWidget {
  final CarouselController carouselController;

  LessonGuideCompare({Key key, this.carouselController}) : super(key: key);

  @override
  _LessonGuideCompareState createState() => _LessonGuideCompareState();
}

class _LessonGuideCompareState extends BaseStateful<LessonGuideCompare>
    with TickerProviderStateMixin {
  int _current = 0;

  List<dynamic> _listGuide = [
    [
      "=",
      AppSounds.getGuideCompareAudio("equal"),
      "1 = 1",
      AppSounds.getGuideCompareAudio("1equal1")
    ],
    [
      ">",
      AppSounds.getGuideCompareAudio("greater"),
      "3 > 1",
      AppSounds.getGuideCompareAudio("3greaterthan1")
    ],
    [
      "<",
      AppSounds.getGuideCompareAudio("less"),
      "1 < 3",
      AppSounds.getGuideCompareAudio("1lessthan3")
    ],
  ];

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

  Widget _buildGuideContent(String sign, String signAudioUrl, String content,
      String contentAudioUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGuideItem(sign, signAudioUrl),
        SizedBox(
          width: AppConstant.defaultSpacing * 4,
        ),
        _buildGuideItem(content, contentAudioUrl)
      ],
    );
  }

  Widget _buildGuideItem(String text, String audioUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 80,
          margin: EdgeInsets.only(right: AppConstant.defaultSpacing),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(AppConstant.defaultSpacing / 2),
              border: Border.all(color: appTheme.warningColor, width: 4)),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
          ),
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
                _audioProvider.playAudio(AudioType.voice, audioUrl);
              },
            ),
          ),
        ),
      ],
    );
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
                items: _listGuide.map((value) {
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
                          child: _buildGuideContent(
                              value[0], value[1], value[2], value[3]));
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _listGuide.map((value) {
                  int index = _listGuide.indexOf(value);
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
