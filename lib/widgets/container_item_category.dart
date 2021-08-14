import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContanierItemCategory extends StatelessWidget {
String title;
String image;
Function() onPressed;

ContanierItemCategory({required this.title,required this.image,required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: SizeConfig.scaleWidth(44),
            height: SizeConfig.scaleHeight(44),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            //  border: Border.all(width: 2,color: AppColors.BORDER)
            ),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: SizeConfig.scaleHeight(3),),
          TextCustom(
            title: title,
            fontfamily: 'pop',
            fontweight: FontWeight.w400,
            size: SizeConfig.scaleTextFont(12),
            align: TextAlign.center,
            color: AppColors.TITLE_ON_BOARDING,
          ),
        ],
      ),
    );
  }

}
