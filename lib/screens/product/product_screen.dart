import 'package:electronic_e_commerce/getx/product_getx_controller.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/screens/product/product_details_screen.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/product_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductScreen extends StatefulWidget {
  int subCategoriesId;

  ProductScreen({required this.subCategoriesId});
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductGetxController controller = Get.put(ProductGetxController());
  @override
  void initState() {
 controller.getProduct(id: widget.subCategoriesId);
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
                child: GetX<ProductGetxController>(
    builder: (ProductGetxController controller) {
    return  controller.loading.value
        ? Center(child: CircularProgressIndicator())
        : controller.products.isNotEmpty
        ? Scrollbar(
                  child: GridView.builder(
                      itemCount: controller.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: (SizeConfig.scaleWidth(165)/SizeConfig.scaleHeight(150)),
                      ),
                      itemBuilder: (context, index) {
                        return ProductItem(onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(ProductId: controller.products[index].id,)),);

                        }, product:controller.products[index],

                        );
                      }),
                ):Center(child: Text('No data',style: TextStyle(
      fontSize: 50
    ),));}),
              ))));

  }
}
