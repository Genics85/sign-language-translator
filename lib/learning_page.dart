import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signintepreter/alphabet_learn.dart';
import 'package:signintepreter/buttons.dart';
import 'package:signintepreter/launch_page.dart';
import 'package:signintepreter/learning_provider.dart';
import 'package:signintepreter/model_provider.dart';

class Learning extends StatefulWidget {
  Learning({Key? key}) : super(key: key);

  @override
  State<Learning> createState() => _LearningState();
}

class _LearningState extends State<Learning> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LearnProvider, ModelProvider>(
        builder: (context, learn, model, child) {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                      label: "Numbers",
                      onpress: () {
                        model.changeToNumber();
                        learn.numberSelected();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LaunchPage(model:model.model)));
                      },
                      image: "images/numbers.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                      label: "Alphabets",
                      onpress: () {
                        model.changeToAlphabet();
                        learn.alphabetSelected();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LaunchPage(model: model.model)));
                      },
                      image: "images/alphabet.png")
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
