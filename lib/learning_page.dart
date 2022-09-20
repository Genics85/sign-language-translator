import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Signer/alphabet_learn.dart';
import 'package:Signer/buttons.dart';
import 'package:Signer/launch_page.dart';
import 'package:Signer/learning_provider.dart';
import 'package:Signer/model_provider.dart';

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
                
                children: [
                  SizedBox(height: 30,),
                  Text("What to Learn ?",style:TextStyle(
                    color: Colors.orange,
                    fontSize:34,
                    fontWeight: FontWeight.w600
                  )),
                  SizedBox(height:MediaQuery.of(context).size.height/3.5 ,),
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
