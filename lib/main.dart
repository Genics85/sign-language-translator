
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signintepreter/learning_page.dart';
import 'package:signintepreter/learning_provider.dart';
import 'package:signintepreter/model_provider.dart';
import 'launch_page.dart';


void main() async {
  return runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<ModelProvider>(create:(context)=>ModelProvider()),
      ChangeNotifierProvider<LearnProvider>(create: (context)=>LearnProvider())
    ],
    child: MyApp(),)
    //  MyApp()
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Signer',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 2000,
        nextScreen:Learning(),
        splash: "images/logo.png",
        splashTransition: SplashTransition.fadeTransition,
      )
      ,
    );
  }
}
