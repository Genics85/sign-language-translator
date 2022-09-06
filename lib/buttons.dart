import "package:flutter/material.dart";

class Button extends StatelessWidget {
  Button(
      {Key? key,
      required this.onpress,
      required this.image,
      this.width=150,
      this.height=100,
      this.color = Colors.orange})
      : super(key: key);
  String image;
  VoidCallback onpress;
  Color color;
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(25), color: color),
      child: ElevatedButton(
        onPressed: onpress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Container(
            width: 70,
            height: 80,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(image)))),
      ),
    );
  }
}
