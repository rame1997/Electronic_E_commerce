import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class TextFiledPassWord extends StatelessWidget {
  String hint;
  TextEditingController textEditingController;
  String? error;
  TextInputType textInputType;
  bool obscureText;
  bool showSuffix;
  Function()?onPressed;

  TextFiledPassWord(
      this.onPressed,
      {required this.hint,
        required this.textEditingController,
        required this.error,
        required this.textInputType,
        required this.obscureText,
        required this.showSuffix});

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: obscureText,
        controller: textEditingController,
        cursorColor: AppColors.MAIN_COLORE,
        keyboardType: textInputType,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: AppColors.MAIN_COLORE,
              ),
            ),
            errorText: error,
            errorMaxLines: 1,
            // errorStyle: ,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
            suffixIcon: showSuffix ? IconButton(
                onPressed: onPressed, icon: Icon(Icons.remove_red_eye, color: this.obscureText ?Colors.grey: AppColors.MAIN_COLORE)):Container()));
  }
}
