import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signintepreter/app_text.dart';
import 'package:signintepreter/learning_provider.dart';
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
    'images/numbers/zero.jpg',
    'images/numbers/one.jpg',
    'images/numbers/two.jpg',
    'images/numbers/three.jpg',
    'images/numbers/four.jpg',
    'images/numbers/five.jpg',
    'images/numbers/six.jpg',
    'images/numbers/seven.jpg',
    'images/numbers/eight.jpg',
  ];

  List alphabetsImage = [
    'images/alphabets/a.jpg',
    'images/alphabets/b.jpg',
    'images/alphabets/c.jpg',
    'images/alphabets/d.jpg',
    'images/alphabets/e.jpg',
    'images/alphabets/f.jpg',
    'images/alphabets/g.jpg',
    'images/alphabets/h.jpg',
    'images/alphabets/i.jpg',
    'images/alphabets/j.jpg',
    'images/alphabets/k.jpg',
    'images/alphabets/l.jpg',
    'images/alphabets/m.jpg',
    'images/alphabets/n.jpg',
    'images/alphabets/o.jpg',
    // 'images/alphabets/p.jpg',
    'images/alphabets/q.jpg',
    'images/alphabets/r.jpg',
    'images/alphabets/s.jpg',
    'images/alphabets/t.jpg',
    'images/alphabets/u.jpg',
    'images/alphabets/v.jpg',
    'images/alphabets/w.jpg',
    'images/alphabets/x.jpg',
    'images/alphabets/y.jpg',
    'images/alphabets/z.jpg',
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

  List alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    // 'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<LearnProvider>(builder: (context, learn, child) {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount:learn.selected? numberImage.length:alphabetsImage.length,
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
                final imageUrl =learn.selected? numberImage[index]:alphabetsImage[index];
                return buildImage(imageUrl, index, learn.selected?numbers[index]:alphabet[index]);
              }),
            ),
            SizedBox(
              height: 40,
            ),
            indicator()
          ],
        ),
      );
    });
  }

  Widget buildImage(String imageUrl, int index, String label) {
    return Consumer<LearnProvider>(builder: (Context, learn, child) {
      return Container(
        child: Container(
          alignment: Alignment.bottomCenter,
          width: 350,
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.cover)),
          child: AppText(
              text: learn.selected ? numbers[index] : alphabet[index],
              color: Colors.white,
              size: 35),
        ),
      );
    });
  }

  Widget indicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: numberImage.length,
      effect: ScrollingDotsEffect(activeDotColor: Colors.orange),
    );
  }
}
