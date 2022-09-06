import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:signintepreter/app_text.dart';
import 'package:signintepreter/carousel.dart';

class Alphabet extends StatefulWidget {
  Alphabet({Key? key}) : super(key: key);

  @override
  State<Alphabet> createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AppText(
            text: "Learn Alphabets",
            color: Colors.white,
          ),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [Carousels()],
          ),
        ),
      ),
    );
  }
}
