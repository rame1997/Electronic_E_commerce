import 'package:electronic_e_commerce/getx/favorite_getx_controller.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/product_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../product_details_screen.dart';

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({Key? key}) : super(key: key);

  @override
  _FavoriteProductsScreenState createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  FavoriteGetxController controller = Get.put(FavoriteGetxController());
  @override
  void initState() {
    controller.getFavoriteProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: TextCustom(
                    title: AppLocalizations.of(context)!.favorite_product,
                    fontfamily: 'pop',
                    fontweight: FontWeight.w600,
                    size: SizeConfig.scaleTextFont(17),
                    align: TextAlign.center,
                    color: Colors.black,
                  ),
                ),
                body:Padding(
                  padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(12),right: SizeConfig.scaleWidth(12),),
                  child: GetX<FavoriteGetxController>(
                      builder: (FavoriteGetxController controller) {
                        return  Scrollbar(
                          child: Column(
                            children: [
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: SharedPrefController()
                                    .languageCode == 'en'
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                                child: TextCustom(
                                    title: AppLocalizations.of(context)!
                                        .all_product,
                                    fontfamily: 'pop',
                                    fontweight: FontWeight.w700,
                                    size: SizeConfig.scaleTextFont(20),
                                    color: AppColors.TITLE_APP_BAR,
                                    align: TextAlign.start),
                              ),
                              InkWell(
                                onTap: () {
                                  for(int i=0;i<controller.favoriteProducts.length;i++){
                                    controller.removeFavoriteProduct(context, controller.favoriteProducts[i].id);
                                  }
                                },
                                child: Align(
                                  alignment: SharedPrefController()
                                      .languageCode == 'en' ? Alignment
                                      .topRight : Alignment.topLeft,
                                  child: TextCustom(
                                      title: AppLocalizations.of(context)!
                                          .remove_all,
                                      fontfamily: 'pop',
                                      fontweight: FontWeight.w500,
                                      size: SizeConfig.scaleTextFont(13),
                                      color: AppColors.MAIN_COLORE,
                                      align: TextAlign.start),
                                ),
                              ),
                            ],
                          ),
                              SizedBox(height: SizeConfig.scaleHeight(15),),
                              Expanded(
                                child: GridView.builder(
                                    itemCount: controller.favoriteProducts.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      childAspectRatio: (SizeConfig.scaleWidth(165)/SizeConfig.scaleHeight(150)),
                                    ),
                                    itemBuilder: (context, index) {
                                      return ProductItem(
                                        onTap: () {
                                      }, product:controller.favoriteProducts[index],

                                      );
                                    }),
                              ),
                            ],
                          ),
                        );}),
                ))));
  }
}
