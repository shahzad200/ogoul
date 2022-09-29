import 'package:flutter/material.dart';
import 'package:ogule/values/colors.dart';


class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton({Key? key,
    required this.text,
    required this.onPress,
    this.textSize = 18.0,
    this.buttonColor = AppColors.blueColor,
    this.textColor = AppColors.whiteColor,
    this.borderColor = AppColors.blueColor,
    this.isRounded = true,
    this.width = double.infinity,
    this.height = 48.0,
    this.elevation = 0,
  this.roundCornersRadius =30.0})
      : super(key: key);
  final String text;
  final VoidCallback? onPress;
  final double textSize;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final bool isRounded;
  final double width;
  final double height;
  final double elevation;
  final double roundCornersRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: textColor,
          textStyle: TextStyle(
            fontSize: textSize,
          ),
          elevation: elevation,
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isRounded ? roundCornersRadius : 0),
              side: BorderSide(color: borderColor)),
        ),
        child: Text(text));
  }
}
