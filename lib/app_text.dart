import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  AppText({Key? key, required this.text, this.color = Colors.black})
      : super(key: key);

  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 16,
      ),
    );
  }
}
