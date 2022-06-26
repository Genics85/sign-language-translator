import 'package:flutter/material.dart';
import 'package:signintepreter/pages/launch_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Interpreter',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const LaunchPage(),
    );
  }
}
