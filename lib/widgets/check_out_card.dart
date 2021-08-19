import 'package:electronic_e_commerce/getx/cart_getx_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'button.dart';

class CheckoutCard extends StatelessWidget with Helpers{


  @override
  Widget build(BuildContext context) {
    CartGetxController controller = Get.put(CartGetxController());

    return   GetX<CartGetxController>(
        builder: (CartGetxController controller) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.scaleHeight(15),
              horizontal: SizeConfig.scaleWidth(30),
            ),
            // height: 174,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -15),
                  blurRadius: 20,
                  color: Color(0xFFDADADA).withOpacity(0.15),
                )
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Total:\n",
                          children: [
                            TextSpan(
                              text: controller.total.value.toString(),
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: SizeConfig.scaleWidth(190),
                        child:
                        button(
                          text:AppLocalizations.of(context)!.check_out,
                          color: AppColors.MAIN_COLORE,
                          onPressed: () {
                            if(controller.cart.isNotEmpty) {
                              Navigator.pushNamed(
                                  context, '/payment_option_screen');
                            }else{
                              showSnackBar(
                                  context,
                                  message:AppLocalizations.of(context)!.cart_empty,
                                  error: true);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}