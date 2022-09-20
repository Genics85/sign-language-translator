import "package:flutter/material.dart";

class BoldText extends StatelessWidget {
  BoldText({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.orange, fontSize: 34, fontWeight: FontWeight.w600),
    );
  }
}
