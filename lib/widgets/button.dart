
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';

class button extends StatelessWidget {
  String text;
  Function() onPressed;
  Color color;

  button({required this.text, required this.onPressed,required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: TextCustom(
          title: text,
          fontfamily: 'pop',
          fontweight: FontWeight.w600,
          size: SizeConfig.scaleTextFont(17),
          align: TextAlign.center,
          color: Colors.white,
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
            primary: color,
            minimumSize: Size(double.infinity, 52)));
  }
}
