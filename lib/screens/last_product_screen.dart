import 'package:electronic_e_commerce/getx/home_getx_controller.dart';
import 'package:electronic_e_commerce/getx/product_getx_controller.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/screens/product_details_screen.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/product_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LastProductScreen extends StatefulWidget {

  @override
  _LastProductScreenState createState() => _LastProductScreenState();
}

class _LastProductScreenState extends State<LastProductScreen> {
  HomeGetxController controller = Get.put(HomeGetxController());
  @override
  void initState() {
    controller.product;
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
                    title: AppLocalizations.of(context)!.product,
                    fontfamily: 'pop',
                    fontweight: FontWeight.w600,
                    size: SizeConfig.scaleTextFont(17),
                    align: TextAlign.center,
                    color: Colors.black,
                  ),
                ),
                body:Padding(
                  padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(12),right: SizeConfig.scaleWidth(12),),
                  child: GetX<HomeGetxController>(
                      builder: (HomeGetxController controller) {
                        return controller.product.isEmpty
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : Scrollbar(
                          child: GridView.builder(
                              itemCount: controller.product.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                childAspectRatio: (SizeConfig.scaleWidth(165)/SizeConfig.scaleHeight(150)),
                              ),
                              itemBuilder: (context, index) {
                                return ProductItem(onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(Product: controller.product[index])),);
                                }, product:controller.product[index],

                                );
                              }),
                        );}),
                ))));

  }
}
