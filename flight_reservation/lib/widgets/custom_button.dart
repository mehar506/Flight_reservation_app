import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double margin;
  final Color? backGroundColor;
  final bool isExpnaded;
  final Color color;
  final double fontSize;
  final double radius;
  final double width;
  final double height;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      this.text = 'SUBMIT',
      this.backGroundColor,
      this.isExpnaded = true,
      this.margin = 10,
      this.color = Colors.white,
      this.fontSize = 16.0,
      this.radius = 19,
      this.width = double.infinity,
      this.height = 62})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpnaded ? width: null,
      height: height ,
      margin: EdgeInsets.symmetric(horizontal: margin, vertical: 10),
      decoration: BoxDecoration(
          gradient: backGroundColor == null
              ? const LinearGradient(
                  colors: [
                    Color(0xff4B9CB2),
                    Color(0xff6446BB),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: backGroundColor ?? Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius))),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: FontWeight.w700,
              fontFamily: 'OpenSans',
            ),
          )),
    );
  }
}
