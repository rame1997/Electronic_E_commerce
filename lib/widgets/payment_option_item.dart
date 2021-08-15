import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class PaymentOptionItem extends StatelessWidget {
  final void Function() onTap;
String title;
String image;
  PaymentOptionItem({ required this.onTap,required this.title,required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(4),right: SizeConfig.scaleWidth(8),top: SizeConfig.scaleHeight(8),bottom: SizeConfig.scaleHeight(8)),
            padding: EdgeInsets.all(0),
            height: SizeConfig.scaleHeight(180),
            width: SizeConfig.scaleWidth(160),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1,color: Colors.grey.withOpacity(0.2))
            ),
            child: SvgPicture.asset(image)
          ),
          SizedBox(
            height: SizeConfig.scaleHeight(5),
          ),
          TextCustom(
              title: title,
              fontfamily: 'pop',
              fontweight: FontWeight.w700,
              size: SizeConfig.scaleTextFont(16),
              color: AppColors.TITLE_ON_BOARDING,
              align: TextAlign.center),
        ],
      ),
    );
  }
}
