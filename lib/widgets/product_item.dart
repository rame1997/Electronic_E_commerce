import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';

// class ProductItem extends StatelessWidget {
//   final Products product;
//   final void Function() onTap;
//
//   ProductItem({required this.product, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap:onTap,
//       child: Container(
//         width: 120,
//         height: 70,
//         child: Card(
//           clipBehavior: Clip.antiAlias,
//           elevation: 2,
//           color: Colors.white,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//           child: Column(
//             children: [
//               Container(
//                 child:
//                 Image.network(product.imageUrl,fit: BoxFit.contain,width:double.infinity,),
//                 width: double.infinity,
//                 height: SizeConfig.scaleHeight(78),
//               ),
//
//               SizedBox(height: SizeConfig.scaleHeight(5),),
//               Expanded(
//                 child: Container(
//                   color: AppColors.grey.withOpacity(0.3),
//                   child: Padding(
//                     padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(4),right: SizeConfig.scaleWidth(4),top: SizeConfig.scaleHeight(5)),
//                     child: Stack(
//                       children: [
//                         Align(
//                           alignment: SharedPrefController().languageCode=='en'?Alignment.topCenter:Alignment.topCenter,
//                           child:  TextCustom(
//                             title:SharedPrefController().languageCode=='en'? product.nameEn:
//                             product.nameAr,
//                             fontfamily: 'pop',
//                             fontweight: FontWeight.w600,
//                             size: SizeConfig.scaleTextFont(12),
//                             align: TextAlign.center,
//                             color: AppColors.TITLE_ON_BOARDING,
//                           ),),
//                         SizedBox(height: SizeConfig.scaleHeight(5),),
//                         Positioned(
//                           bottom: 5,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               TextCustom(
//                                 title: '\$'+product.price.toString(),
//                                 fontfamily: 'pop',
//                                 fontweight: FontWeight.w700,
//                                 size: SizeConfig.scaleTextFont(14),
//                                 align: TextAlign.center,
//                                 color: AppColors.TITLE_ON_BOARDING,
//                               ),
//                               SizedBox(width: SizeConfig.scaleWidth(70),),
//                               TextCustom(
//                                 title: product.quantity.toString()+' Piecs',
//                                 fontfamily: 'pop',
//                                 fontweight: FontWeight.w500,
//                                 size: SizeConfig.scaleTextFont(12),
//                                 align: TextAlign.center,
//                                 color: AppColors.TITLE_ON_BOARDING,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
// }

class ProductItem extends StatelessWidget {
  final Products product;
  final void Function() onTap;

  ProductItem({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              // padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(4),right: SizeConfig.scaleWidth(8),top: SizeConfig.scaleHeight(8),bottom: SizeConfig.scaleHeight(8)),
              padding: EdgeInsets.all(0),
              height: SizeConfig.scaleHeight(180),
              width: SizeConfig.scaleWidth(160),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1,color: Colors.grey.withOpacity(0.2))
              ),
              child: Hero(
                tag: "${product.id}",
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: SizeConfig.scaleHeight(16) / 4),
            child: Align(
              alignment: SharedPrefController().languageCode == 'en'
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: TextCustom(
                title: SharedPrefController().languageCode == 'en'
                    ? product.nameEn
                    : product.nameAr,
                fontfamily: 'pop',
                fontweight: FontWeight.w700,
                size: SizeConfig.scaleTextFont(12),
                align: TextAlign.center,
                color: AppColors.TITLE_ON_BOARDING,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextCustom(
                title: '\$' + product.price.toString(),
                fontfamily: 'pop',
                fontweight: FontWeight.w600,
                size: SizeConfig.scaleTextFont(14),
                align: TextAlign.center,
                color: AppColors.TITLE_ON_BOARDING,
              ),
              SizedBox(
                width: SizeConfig.scaleWidth(70),
              ),
              TextCustom(
                title: product.quantity.toString() + ' Piecs',
                fontfamily: 'pop',
                fontweight: FontWeight.w400,
                size: SizeConfig.scaleTextFont(12),
                align: TextAlign.center,
                color: AppColors.TITLE_ON_BOARDING,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
