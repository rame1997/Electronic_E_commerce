import 'package:electronic_e_commerce/getx/categories_getx_controller.dart';
import 'package:electronic_e_commerce/getx/home_getx_controller.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/screens/product_screen.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/category_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatefulWidget {
int categoriesId;

SubCategoriesScreen({required this.categoriesId});

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  CategoryGetxController controller = Get.put(CategoryGetxController());

  @override
  void initState() {
    controller.getSubCategories(id: widget.categoriesId);
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
    title: AppLocalizations.of(context)!.sub_categories,
    fontfamily: 'pop',
    fontweight: FontWeight.w600,
    size: SizeConfig.scaleTextFont(17),
    align: TextAlign.center,
    color: Colors.black,
    ),

    ),
      body: Padding(
    padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(12),right: SizeConfig.scaleWidth(12),),
    child: Column(
    children: [
    Align(
    alignment: SharedPrefController().languageCode=='en'?Alignment.topLeft:Alignment.topRight,
    child: TextCustom(
    title: AppLocalizations.of(context)!.sub_categories,
    fontfamily: 'pop',
    fontweight: FontWeight.w700,
    size: SizeConfig.scaleTextFont(20),
    color: AppColors.TITLE_APP_BAR,
    align: TextAlign.start),
    ),
    Container(
          child: GetX<CategoryGetxController>(
            builder: (CategoryGetxController controller) {
              return controller.subCategories.isEmpty
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: controller.subCategories.length,
                itemBuilder: (context, index) {
                  return CategoryItem(title:
                  SharedPrefController().languageCode=='en'? controller.subCategories[index].nameEn:
                  controller.subCategories[index].nameAr
                    ,
                    image: controller.subCategories[index].imageUrl, onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(subCategoriesId: controller.subCategories[index].id)),);
                     //   Get.to(ProductScreen(subCategoriesId: controller.subCategories[index].id)),

                      },
                    subTitle: controller.subCategories[index].productsCount.toString()+AppLocalizations.of(context)!.product,);
                  // return CategoryItem(
                  //     subCategory: controller.subCategories[index],
                  //     onTap: () => Get.to(ProductScreen(id: controller.subCategories[index].id)), subTitle: controller.subCategories[index]., title: '', image: '',);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: SizeConfig.scaleHeight(20),);
                },
              );
            },
          ),
        ),
    ]
      ),
    ))));
  }
}

