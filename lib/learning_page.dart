import 'package:flutter/material.dart';
import 'package:signintepreter/alphabet_learn.dart';
import 'package:signintepreter/buttons.dart';

class Learning extends StatefulWidget {
  Learning({Key? key}) : super(key: key);

  @override
  State<Learning> createState() => _LearningState();
}

class _LearningState extends State<Learning> {
  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (Context) => Alphabet()));
                    },
                    image: "images/numbers.png"),
                const SizedBox(
                  height: 20,
                ),
                Button(label: "Alphabets",onpress: () {}, image: "images/alphabet.png")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
