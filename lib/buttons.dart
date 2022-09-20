import "package:flutter/material.dart";
import 'package:Signer/app_text.dart';

class Button extends StatelessWidget {
  Button(
      {Key? key,
      this.text = '',
      required this.onpress,
      required this.image,
      this.imageHeight = 80,
      this.imageWidth = 70,
      this.label ="nothing",
      this.width = 150,
      this.height = 100,
      this.color = Colors.orange})
      : super(key: key);
  String label;
  double imageWidth;
  double imageHeight;
  String image;
  String text;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image)))),
            SizedBox(height: 3),
            AppText(text:label, size: 10, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
