import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LessonGuideCarousel extends StatefulWidget {
  final int lessonId;

  LessonGuideCarousel({Key key, this.lessonId}) : super(key: key);

  @override
  _LessonGuideCarouselState createState() => _LessonGuideCarouselState();
}

class _LessonGuideCarouselState extends State<LessonGuideCarousel> {
  int _current = 0;
  List listImage1 = [
    'assets/base/images/carousel/l1_img1.png',
    'assets/base/images/carousel/l1_img2.png',
    'assets/base/images/carousel/l1_img3.png',
    'assets/base/images/carousel/l1_img4.png',
  ];

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (widget.lessonId) {
      case 1:
        return Container(child: _buildCarousel(listImage1));
      case 2:
        return Container(child: _buildCarousel(listImage1));
      case 3:
        return Container(child: _buildCarousel(listImage1));
      case 4:
        return Container(child: _buildCarousel(listImage1));
      case 4:
        return Container(child: _buildCarousel(listImage1));
    }
  }

  Column _buildCarousel(List listImage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: listImage.map((imgUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Image.asset(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listImage.map((url) {
            int index = listImage.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.grey[300] : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
