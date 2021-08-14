import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';


class CardContant extends StatelessWidget {
  String title;
  String titleWidget;
  int index;

  CardContant(this.titleWidget, this.title, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.scaleHeight(6),
            horizontal: SizeConfig.scaleWidth(8)),
        child: ExpansionTile(
          title:TextCustom(
              title: titleWidget,
              fontfamily: 'pop',
              fontweight: FontWeight.w700,
              size: SizeConfig.scaleTextFont(18),
              color: AppColors.MAIN_COLORE,
              align: TextAlign.start)
        ,

          children: [
            Container(
              width: double.infinity,
              height: SizeConfig.scaleHeight(65),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: SizeConfig.scaleWidth(8)),
                        child:TextCustom(
                            title: title,
                            fontfamily: 'pop',
                            fontweight: FontWeight.w700,
                            size: SizeConfig.scaleTextFont(15),
                            color: AppColors.TITLE_ON_BOARDING,
                            align: TextAlign.start)

                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
