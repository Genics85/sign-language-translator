import 'package:flutter/material.dart';
import 'launch_page.dart';

void main() {
  runApp(const MyApp());
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