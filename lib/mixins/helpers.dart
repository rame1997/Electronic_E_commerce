import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';

import '../utilities/app_colors.dart';

mixin Helpers {
  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }


showAlertDialog(BuildContext context, String title, String content) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(side: BorderSide(color: AppColors.RED)),
            title: TextCustom(
                title: title,
                fontfamily: 'pop',
                fontweight: FontWeight.w500,
                size: SizeConfig.scaleTextFont(15),
                color: AppColors.RED,
                align: TextAlign.left),
            content: TextCustom(
                title: content,
                fontfamily: 'pop',
                fontweight: FontWeight.w400,
                size: SizeConfig.scaleTextFont(12),
                color: AppColors.TITLE_ON_BOARDING,
                align: TextAlign.left),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: TextCustom(
                    title: 'No',
                    fontfamily: 'pop',
                    fontweight: FontWeight.w500,
                    size: SizeConfig.scaleTextFont(12),
                    color: AppColors.TITLE_ON_BOARDING,
                    align: TextAlign.left),
              ),
              TextButton(
                onPressed: () {},
                child: TextCustom(
                    title: 'Yes',
                    fontfamily: 'pop',
                    fontweight: FontWeight.w500,
                    size: SizeConfig.scaleTextFont(12),
                    color: AppColors.RED,
                    align: TextAlign.left),
              )
            ],
          ));
}

}