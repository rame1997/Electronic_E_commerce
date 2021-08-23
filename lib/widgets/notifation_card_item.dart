import 'dart:ui';

import 'package:electronic_e_commerce/models/notafiction.dart';
import 'package:electronic_e_commerce/models/order.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NotifiactionCard extends StatelessWidget {
  const NotifiactionCard({
    required this.notifation,required this.onPress, required this.index
  });

  final Notifation notifation;
  final int index;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    int indexLocal=index+1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: onPress,
            child: Row(
              children: [
                CircleAvatar(
                  radius: SizeConfig.scaleHeight(25),
                  backgroundColor: AppColors.MAIN_COLORE,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications,
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
                        notifation.title,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      SizedBox(height: SizeConfig.scaleHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: notifation.subtitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, color: AppColors.TITLE_ON_BOARDING),
                              children: [

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
        ),

      ],
    );
  }
}