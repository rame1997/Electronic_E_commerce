
import 'package:electronic_e_commerce/getx/cart_getx_controller.dart';

import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/cart_body.dart';
import 'package:electronic_e_commerce/widgets/check_out_card.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartScreen extends StatefulWidget {


  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartGetxController controller = Get.put(CartGetxController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body:
        GetX<CartGetxController>(
            builder: (CartGetxController controller) {
              return
        Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(right: SizeConfig.scaleWidth(16),left: SizeConfig.scaleWidth(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  InkWell(
                    onTap: () {
                     controller.removeAll();
                     controller.total.value=0;
                    },
                    child: Align(
                      alignment: SharedPrefController()
                          .languageCode == 'en' ? Alignment
                          .topRight : Alignment.topRight,
                      child: TextCustom(
                          title: AppLocalizations.of(context)!
                              .remove_all,
                          fontfamily: 'pop',
                          fontweight: FontWeight.w600,
                          size: SizeConfig.scaleTextFont(14),
                          color: AppColors.MAIN_COLORE,
                          align: TextAlign.start),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(15),),
            Expanded(child:  Body(products: controller.cart.value, quitity: controller.quitityCount.value,))

          ],
        );
  }),
        bottomNavigationBar: CheckoutCard(),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
          AppLocalizations.of(context)!.your_cart,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}