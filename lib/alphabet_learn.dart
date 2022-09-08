import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:signintepreter/app_text.dart';
import 'package:signintepreter/carousel.dart';
import 'package:signintepreter/learning_provider.dart';

class Alphabet extends StatefulWidget {
  Alphabet({Key? key}) : super(key: key);

  @override
  State<Alphabet> createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {

  @override
  Widget build(BuildContext context) {
    return Consumer<LearnProvider>(builder: (context,learn,child){
      return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AppText(
            text:learn.selected?"Numbers":"Alphabets",
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
    });
    
     
  }
}
