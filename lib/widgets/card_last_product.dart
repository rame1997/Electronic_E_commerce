import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';

class CardLastProduct extends StatelessWidget {
  String mainImage;
  String title;
  int quaitity;
  int price;
  String detiles;
  Function()? onPress;


  CardLastProduct(
      {required this.mainImage, required this.title, required this.detiles, required this.price, this.onPress,required this.quaitity});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPress,
      child: Container(
        width: SizeConfig.scaleWidth(140),
        height: SizeConfig.scaleHeight(70),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          color: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Container(
                child:
                Image.network(mainImage,fit: BoxFit.cover,width: double.infinity,),
                width: double.infinity,
                height: SizeConfig.scaleHeight(70),
              ),

              SizedBox(height: SizeConfig.scaleHeight(10),),
              Padding(
                padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(4),right: SizeConfig.scaleWidth(4)),
                child: Column(
                  children: [
                    Align(
                      alignment: SharedPrefController().languageCode=='en'?Alignment.topLeft:Alignment.topRight,
                      child:  TextCustom(
                        title: title,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w600,
                        size: SizeConfig.scaleTextFont(12),
                        align: TextAlign.center,
                        color: AppColors.TITLE_ON_BOARDING,
                      ),),
                    SizedBox(height: SizeConfig.scaleHeight(5),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                          title: '\$'+price.toString(),
                          fontfamily: 'pop',
                          fontweight: FontWeight.w700,
                          size: SizeConfig.scaleTextFont(14),
                          align: TextAlign.center,
                          color: AppColors.TITLE_ON_BOARDING,
                        ),
                        TextCustom(
                          title: quaitity.toString()+' Piecs',
                          fontfamily: 'pop',
                          fontweight: FontWeight.w500,
                          size: SizeConfig.scaleTextFont(12),
                          align: TextAlign.center,
                          color: AppColors.TITLE_ON_BOARDING,
                        ),
                      ],
                    ),
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}

