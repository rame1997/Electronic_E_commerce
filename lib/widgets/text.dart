import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String title;
  final String fontfamily;
  final FontWeight fontweight;
  final double size;
  final Color color;
  final TextAlign align;

  TextCustom(
      {required this.title,
      required this.fontfamily,
      required this.fontweight,
      required this.size,
      required this.color,
      required this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: TextStyle(
          fontFamily: fontfamily,
          fontWeight: fontweight,
          fontSize: size,
          color: color),
    );
  }
}
