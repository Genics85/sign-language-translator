import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signintepreter/alphabet_learn.dart';
import 'package:signintepreter/buttons.dart';
import 'package:signintepreter/learning_provider.dart';

class Learning extends StatefulWidget {
  Learning({Key? key}) : super(key: key);

  @override
  State<Learning> createState() => _LearningState();
}

class _LearningState extends State<Learning> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LearnProvider>(builder: (context, learn, child) {
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
                        learn.numberSelected();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (Context) => Alphabet()));
                      },
                      image: "images/numbers.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  Button(
                      label: "Alphabets",
                      onpress: () {
                        learn.alphabetSelected();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Alphabet()));
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
