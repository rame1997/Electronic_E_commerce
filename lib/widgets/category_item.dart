import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
String title;
String image;
String subTitle;
Function() onTap;


CategoryItem({required this.title, required this.image, required this.onTap,required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(4),right: SizeConfig.scaleWidth(4)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
          Flexible(
            child: Row(
              children: [
                Container(
                width: SizeConfig.scaleWidth(50),
                height: SizeConfig.scaleHeight(50),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.network(image),),
                SizedBox(width: SizeConfig.scaleWidth(10),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 250),
                      child: TextCustom(
                        title: title,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w600,
                        size: SizeConfig.scaleTextFont(16),
                        align: TextAlign.start,
                        color: AppColors.TITLE_ON_BOARDING,
                      ),
                    ),
                    TextCustom(
                      title: subTitle,
                      fontfamily: 'pop',
                      fontweight: FontWeight.w300,
                      size: SizeConfig.scaleTextFont(12),
                      align: TextAlign.start,
                      color: AppColors.TITLE_ON_BOARDING,
                    ),
                  ],
                ),
              ],
            ),
          ),

Icon(Icons.arrow_forward,color: AppColors.MAIN_COLORE,)
          ],
        ),
      ),
    );
  }
}
