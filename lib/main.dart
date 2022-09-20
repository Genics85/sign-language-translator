import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Signer/app_text.dart';
import 'package:Signer/learning_page.dart';
import 'package:Signer/learning_provider.dart';
import 'package:Signer/model_provider.dart';
import 'launch_page.dart';

void main() async {
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ModelProvider>(
          create: (context) => ModelProvider()),
      ChangeNotifierProvider<LearnProvider>(
          create: (context) => LearnProvider())
    ],
    child: MyApp(),
  )
      //  MyApp()
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signer',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splashIconSize: 300,
        duration: 5000,
        nextScreen: Learning(),
        splash: Container(
          alignment: Alignment.center,
          child: Column(children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                "images/logo.png"
              ),fit: BoxFit.cover)),
            ),
            const SizedBox(height: 20,),
            const Text("SIGNER",style: TextStyle(
              color: Colors.orange,
              fontSize: 34,
              fontWeight: FontWeight.w800
            ),)
            
          ]),
        ),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
