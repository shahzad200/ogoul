import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading(
      {Key? key,
        required this.text,
        this.fontSize = 40.0,
        this.textColor = Colors.black,
        this.textAlign,
        })
      : super(key: key);
  final String text;

  final double fontSize;
  final Color textColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w900, fontSize: fontSize, color: textColor,),
      textAlign: textAlign ,
    );
  }
}
