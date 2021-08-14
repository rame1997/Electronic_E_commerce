import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'button.dart';


class AddToCart extends StatelessWidget {
  final Products product;
  Function() onPressAddToCart;
  Function() onPressToCart;
  AddToCart({
    required this.product,required this.onPressAddToCart,required this.onPressToCart
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: SizeConfig.scaleHeight(16)),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: SizeConfig.scaleWidth(16)),
            height: SizeConfig.scaleHeight(50),
            width: SizeConfig.scaleWidth(58),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),

              onPressed: onPressToCart,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,

              child:
              button(
                text: AppLocalizations.of(context)!.add_to_cart,
                color: AppColors.MAIN_COLORE,
                onPressed:onPressAddToCart

              ),
            ),
          ),
        ],
      ),
    );
  }
}