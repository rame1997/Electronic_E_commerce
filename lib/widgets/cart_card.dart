import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';


class CartCard extends StatelessWidget {
  const CartCard({
    required this.Product,
  });

  final Products Product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(SizeConfig.scaleHeight(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(Product.imageUrl),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SharedPrefController().languageCode ==
                  'en'
                  ? Product.nameEn
                  : Product.nameAr,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${Product.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: AppColors.TITLE_ON_BOARDING),
                children: [
                  TextSpan(
                      text: " x${Product.quantity}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}