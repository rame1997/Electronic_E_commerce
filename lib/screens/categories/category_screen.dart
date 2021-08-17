import 'package:carousel_slider/carousel_controller.dart';
import 'package:electronic_e_commerce/getx/home_getx_controller.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/screens/categories/sub_categories_screen.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/category_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  HomeGetxController _homeController = Get.put(HomeGetxController());

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
                  title: AppLocalizations.of(context)!.category,
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
                          title: AppLocalizations.of(context)!.category,
                          fontfamily: 'pop',
                          fontweight: FontWeight.w700,
                          size: SizeConfig.scaleTextFont(20),
                          color: AppColors.TITLE_APP_BAR,
                          align: TextAlign.start),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(15),),
                    Expanded(child:
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: _homeController.data[0].categories.length,
                      itemBuilder: (BuildContext context,int index){
                        return CategoryItem(title:
                        SharedPrefController().languageCode=='en'? _homeController.data[0].categories[index].nameEn:
                        _homeController.data[0].categories[index].nameAr
                          ,
                          image: _homeController.data[0].categories[index].imageUrl, onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoriesScreen(categoriesId: _homeController.data[0].categories[index].id,)),);
                          }, subTitle: _homeController.data[0].categories[index].subCategoriesCount.toString()+AppLocalizations.of(context)!.sub_categories,);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: SizeConfig.scaleHeight(20),);
                      },
                    ),
                    )
                  ],
                ),
              ),
            )
        ) );  }
}
