import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';

class PriceAndPiecesItem extends StatelessWidget {
  final Products product;

  const PriceAndPiecesItem({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.price),
SizedBox(height: SizeConfig.scaleHeight(5)),
              TextCustom(
                title: '\$'+product.price.toString(),
                fontfamily: 'pop',
                fontweight: FontWeight.w700,
                size: SizeConfig.scaleTextFont(12),
                align: TextAlign.center,
                color: AppColors.TITLE_ON_BOARDING,
              ),
            ],
          ),
        ),
        Expanded(
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.quantity),
              SizedBox(height: SizeConfig.scaleHeight(5)),
              TextCustom(
                title: "${product.quantity.toString()} Pieses",
                fontfamily: 'pop',
                fontweight: FontWeight.w700,
                size: SizeConfig.scaleTextFont(12),
                align: TextAlign.center,
                color: AppColors.TITLE_ON_BOARDING,
              ),
            ],
          ),
          // RichText(
          //   text: TextSpan(
          //     style: TextStyle(color: AppColors.TITLE_ON_BOARDING),
          //     children: [
          //       TextSpan(text: AppLocalizations.of(context)!.quantity+ "\n"),
          //       TextSpan(
          //         text: "${product.quantity} Pieses",
          //
          //
          //             ),
          //
          //     ],
          //   ),
          // ),
        ),
      ],
    );
  }
}