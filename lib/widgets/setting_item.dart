import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  String title;
  IconData icon;
  String subTitle;
  Function() onTap;
  int index;

  SettingItem({required this.title, required this.icon, required this.subTitle, required this.onTap,required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: SizeConfig.scaleHeight(10)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        shadowColor: AppColors.SHADOW,
        child: Row(
          children: [
            Container(
              height: SizeConfig.scaleHeight(70),
              width: SizeConfig.scaleWidth(5),
              decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? Colors.white
                      : AppColors.MAIN_COLORE),
            ),
            Expanded(
                child: Padding(
                  padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(8),right: SizeConfig.scaleWidth(8)),
                  child: InkWell(
                    onTap: onTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: SizeConfig.scaleHeight(25),
                                backgroundColor: AppColors.MAIN_COLORE,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      icon,
                                      color: Colors.white,
                                      size: SizeConfig.scaleHeight(20),
                                    )),
                              ),
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
                                      size: SizeConfig.scaleTextFont(14),
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
                ),
            ),
            Container(
              height: SizeConfig.scaleHeight(70),
              width: SizeConfig.scaleWidth(5),
              decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? AppColors.MAIN_COLORE
                      : Colors.white),
            ),
          ],
        ),
      ),
    );


  }
}
