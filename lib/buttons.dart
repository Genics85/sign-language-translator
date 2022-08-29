import "package:flutter/material.dart";

class Button extends StatelessWidget {
  Button(
      {Key? key,
      required this.onpress,
      required this.icon,
      this.color = Colors.orange})
      : super(key: key);

  VoidCallback onpress;
  Icon icon;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(25),
        color: color
      ),
      child: ElevatedButton(
        onPressed: onpress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: icon,
      ),
    );
  }
}
