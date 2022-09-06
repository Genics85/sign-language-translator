import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  AppText(
      {Key? key, required this.text, this.color = Colors.black, this.size = 16})
      : super(key: key);
  double size;
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize:size,
      ),
    );
  }
}
