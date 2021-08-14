
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String sub_title;

  OnBoardingContent({
    required this.image,
    required this.title,
    required this.sub_title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.scaleHeight(227)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(image),
          SizedBox(
            height: SizeConfig.scaleHeight(40),
          ),
          TextCustom(
              title: title,
              fontfamily: 'pop',
              fontweight: FontWeight.w700,
              size: SizeConfig.scaleTextFont(20),
              color: AppColors.TITLE_ON_BOARDING,
              align: TextAlign.center),
          SizedBox(
            height: SizeConfig.scaleHeight(14),
          ),
          TextCustom(
              title: sub_title,
              fontfamily: 'pop',
              fontweight: FontWeight.w400,
              size: SizeConfig.scaleTextFont(16),
              color: AppColors.SUB_TITLE_ON_BOARDING,
              align: TextAlign.center),
        ],
      ),
    );
  }
}
