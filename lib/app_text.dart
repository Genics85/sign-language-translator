import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  AppText({Key? key, required this.text}) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: const TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),);
  }
}
