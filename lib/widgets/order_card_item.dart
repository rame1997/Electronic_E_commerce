import 'dart:ui';

import 'package:electronic_e_commerce/models/order.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.order,required this.onPress, required this.index
  });

  final Order order;
  final int index;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    int indexLocal=index+1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                radius: SizeConfig.scaleHeight(25),
                backgroundColor: AppColors.MAIN_COLORE,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark,
                      color: Colors.white,
                      size: SizeConfig.scaleHeight(20),
                    )),
              ),
              SizedBox(width: SizeConfig.scaleWidth(10),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SharedPrefController().languageCode ==
                          'en'
                          ? 'Order '+indexLocal.toString()
                          :indexLocal.toString() +' الطلب',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      maxLines: 2,
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(10)),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text.rich(
                       TextSpan(
                         text: '\$'+ order.total.toString(),
                         style: TextStyle(
                             fontWeight: FontWeight.w600, color: AppColors.TITLE_ON_BOARDING),
                         children: [
                           TextSpan(
                               text: ' x'+order.orderProductsCount.toString(),
                               style: Theme.of(context).textTheme.bodyText1),
                         ],
                       ),
                     ),
                     Text.rich(
                       TextSpan(
                         text: AppLocalizations.of(context)!.status,
                         style: TextStyle(
                             fontWeight: FontWeight.w600, color: AppColors.TITLE_ON_BOARDING),
                         children: [
                           TextSpan(
                               text: ' :'+order.status,
                               style: TextStyle(color: AppColors.MAIN_COLORE)),
                         ],
                       ),
                     ),
                   ],
                 )
                  ],
                ),
              ),

            ],
          ),
        ),
        SizedBox(width: SizeConfig.scaleWidth(30)),
        Row(
          children: [
            IconButton(onPressed: onPress, icon: Icon(Icons.arrow_forward,color: AppColors.MAIN_COLORE,)),
          ],
        )
      ],
    );
  }
}