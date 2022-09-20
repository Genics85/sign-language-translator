import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:Signer/app_text.dart';
import 'package:Signer/carousel.dart';
import 'package:Signer/learning_provider.dart';
import 'package:Signer/model_provider.dart';

import 'buttons.dart';
import 'camera_page.dart';

class Alphabet extends StatefulWidget {
  Alphabet({Key? key}) : super(key: key);

  @override
  State<Alphabet> createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LearnProvider, ModelProvider>(
        builder: (context, learn, model, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: AppText(
              text: learn.selected ? "Numbers" : "Alphabets",
              color: Colors.white,
              size: 20,
            ),
            backgroundColor: Colors.orange,
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Carousels(),
                SizedBox(
                  height: 50,
                ),
                Button(
                  label: "Practice",
                  image: "images/video.png",
                  onpress: () async {
                    await availableCameras().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CameraPage(
                                  cameras: value,
                                  model: model.model,
                                ))));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
