import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:signintepreter/app_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousels extends StatefulWidget {
  Carousels({
    Key? key,
  }) : super(key: key);

  @override
  State<Carousels> createState() => _CarouselsState();
}

class _CarouselsState extends State<Carousels> {
  int activeIndex = 0;
  List numberImage = [
    'images/zero.jpg',
    'images/one.jpg',
    'images/two.jpg',
    'images/three.jpg',
    'images/four.jpg',
    'images/five.jpg',
    'images/six.jpg',
    'images/seven.jpg',
    'images/eight.jpg',
  ];

  List numbers = [
    'ZERO',
    'ONE',
    'TWO',
    'THREE',
    'FOUR',
    'FIVE',
    'SIX',
    'SEVEN',
    'EIGHT',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: numberImage.length,
            options: CarouselOptions(
              height: 400,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
            itemBuilder: ((context, index, realIndex) {
              final imageUrl = numberImage[index];
              return buildImage(imageUrl, index, numbers[index]);
            }),
          ),
          SizedBox(height: 40,),
          indicator()
        ],
      ),
    );
  }

  Widget buildImage(String imageUrl, int index, String label) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: AssetImage(imageUrl), fit: BoxFit.cover)),
      ),
    );
  }

  Widget indicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: numberImage.length,
      effect: ScrollingDotsEffect(activeDotColor: Colors.orange),
    );
  }
}
