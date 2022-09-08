
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signintepreter/learning_provider.dart';
import 'launch_page.dart';


void main() async {
  return runApp(
    MultiProvider(providers: [
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
    return const MaterialApp(
      title: 'Sign language interpreter',
      debugShowCheckedModeBanner: false,
      home: LaunchPage(),
    );
  }
}
