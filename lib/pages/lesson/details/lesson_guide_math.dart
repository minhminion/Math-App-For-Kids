import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_constant.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_sounds.dart';

class LessonGuideAdditionAndSubtraction extends StatefulWidget {
  final CarouselController carouselController;
  final String operator;

  LessonGuideAdditionAndSubtraction(
      {Key key, this.carouselController, this.operator})
      : super(key: key);

  @override
  _LessonGuideAdditionAndSubtractionState createState() =>
      _LessonGuideAdditionAndSubtractionState();
}

class _LessonGuideAdditionAndSubtractionState
    extends BaseStateful<LessonGuideAdditionAndSubtraction>
    with TickerProviderStateMixin {
  int _current = 0;
  List<dynamic> _listAddGuide = [
    [1, 1, AppSounds.getGuideMathAudio("1plus1")],
    [2, 2, AppSounds.getGuideMathAudio("2plus2")],
    [3, 1, AppSounds.getGuideMathAudio("3plus1")],
  ];
  List<dynamic> _listSubGuide = [
    [2, 1, AppSounds.getGuideMathAudio("2minus1")],
    [4, 2, AppSounds.getGuideMathAudio("4minus2")]
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
    return _buildMathGuide();
  }

  Widget _buildGuideContent(int numA, int numB, String audioUrl) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMathGuideItem(numA),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstant.defaultSpacing * 2),
              child: Text(widget.operator,
                  style: TextStyle(color: Colors.white, fontSize: 40)),
            ),
            _buildMathGuideItem(numB),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstant.defaultSpacing * 2),
              child: Text("=",
                  style: TextStyle(color: Colors.white, fontSize: 40)),
            ),
            _buildMathGuideItem(
                widget.operator == "+" ? numA + numB : numA - numB)
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
                  _audioProvider.playAudio(AudioType.voice, audioUrl);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMathGuideItem(int number) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
        ),
        Wrap(
          children: [
            ...List<Widget>.filled(number,
                Image(width: 50, image: AssetImage(appTheme.assets.planet(2))))
          ],
        ),
        SizedBox(
          height: AppConstant.defaultSpacing * 2,
        ),
        Text(number.toString(),
            style: TextStyle(color: Colors.white, fontSize: 40))
      ],
    );
  }

  Widget _buildMathGuide() {
    List<dynamic> _listContent =
        widget.operator == "+" ? _listAddGuide : _listSubGuide;

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
                items: _listContent.map((value) {
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
                          child:
                              _buildGuideContent(value[0], value[1], value[2]));
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _listContent.map((value) {
                  int index = _listContent.indexOf(value);
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
