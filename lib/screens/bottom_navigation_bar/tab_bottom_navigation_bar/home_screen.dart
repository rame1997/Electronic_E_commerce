import 'package:electronic_e_commerce/getx/cart_getx_controller.dart';
import 'package:electronic_e_commerce/getx/home_getx_controller.dart';
import 'package:electronic_e_commerce/getx/user_getx_controller.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/screens/product/product_details_screen.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/card_last_product.dart';
import 'package:electronic_e_commerce/widgets/container_item_category.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../categories/sub_categories_screen.dart';
import '../../order_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeGetxController _homeController;
  late CartGetxController cartGetxController;
  int length=0;

  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(UserGetxController());
    _homeController = Get.put(HomeGetxController());
    cartGetxController = Get.put(CartGetxController());
    Future.delayed(Duration.zero, () async {
      await HomeGetxController.to.getHome();
    });
    }
  int _current = 0;
  final CarouselController _controller = CarouselController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: SizeConfig.scaleWidth(15),
              right: SizeConfig.scaleWidth(15),
              top: SizeConfig.scaleHeight(40)),
          child:
                    SingleChildScrollView(
                      child: Column(
                          children: [
                            GetX<CartGetxController>(
                                builder: (CartGetxController controller) {
                           return Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: SizeConfig.scaleHeight(44),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.BACK_GROUND_SEARCH,
                                      borderRadius: BorderRadius.circular(
                                          SizeConfig.scaleHeight(12)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.scaleWidth(13),
                                          right: SizeConfig.scaleWidth(13)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search, color: AppColors.grey,
                                            size: SizeConfig.scaleHeight(24),),
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(8),),
                                          Expanded(
                                            child: TextField(onTap: () {},
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: AppLocalizations.of(
                                                      context)!.search,
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: SizeConfig.scaleWidth(5),),
                                Container(
                                    height: 44.0,
                                    width: 30.0,
                                    child: new GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,'/cart_screen'
                                        );
                                      },

                                      child: Stack(

                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.shopping_cart,
                                              color: AppColors.MAIN_COLORE,),
                                            onPressed: null,
                                          ),
                                          controller.cart.value.length == 0 ? Container() :
                                          Positioned(

                                              child: Stack(
                                                children: <Widget>[

                                                  Positioned(
                                                      top: 2.0,
                                                      right: 4.0,
                                                      child: Center(
                                                        child: new Text(
                                                          controller.cart.value.length
                                                              .toString(),
                                                          style: new TextStyle(
                                                              color: AppColors
                                                                  .MAIN_COLORE,
                                                              fontSize: 12.0,
                                                              fontWeight: FontWeight
                                                                  .w500
                                                          ),
                                                        ),
                                                      )),


                                                ],
                                              )),

                                        ],
                                      ),
                                    )
                                )

                                ,
                              ],
                            );
  }
  ),
                            GetX<HomeGetxController>(
                                builder: (HomeGetxController controller) {
                                  List<String> image=[];
                                  List<Widget> imageSliders=[];
if(controller.data.isNotEmpty){
    image = [
for(var i = 0; i < controller.data.value[0].slider.length; i++)
  controller.data.value[0].slider[i].imageUrl
                                  ];
                                   imageSliders = image
                                      .map((item) =>
                                  Container(
                                  child: Container(
                                  margin: EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  child: Stack(
                                  children: <Widget>[
                                  Image.network(item, fit: BoxFit.cover, width: 1000.0),

                                  ],
                                  )),
                                  ),
                                  ))
                                      .toList();}

                                  return controller.loading.value
                                      ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                      : controller.data.isNotEmpty
                                  ?
                            Column(
                              children: [
                                SizedBox(height: SizeConfig.scaleHeight(20),),
                                Container(
                                  width: double.infinity,
                                  height: SizeConfig.scaleHeight(190),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: CarouselSlider(
                                          items: imageSliders,
                                          carouselController: _controller,
                                          options: CarouselOptions(
                                              autoPlay: true,
                                              enlargeCenterPage: true,
                                              aspectRatio: 2.0,
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  _current = index;
                                                });
                                              }),
                                        ),
                                      )
                                      ,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: image
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          return GestureDetector(
                                            onTap: () {
                                              _controller.animateToPage(entry.key);
                                              print(_homeController.data);
                                            },
                                            child: Container(
                                              width: SizeConfig.scaleWidth(8),
                                              height: SizeConfig.scaleHeight(8),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8.0, horizontal: 4.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: (Theme
                                                      .of(context)
                                                      .brightness == Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black)
                                                      .withOpacity(
                                                      _current == entry.key
                                                          ? 0.9
                                                          : 0.4)),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(8),),
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
                                              .category,
                                          fontfamily: 'pop',
                                          fontweight: FontWeight.w700,
                                          size: SizeConfig.scaleTextFont(20),
                                          color: AppColors.TITLE_APP_BAR,
                                          align: TextAlign.start),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print(_homeController.data[0].categories[2]
                                            .nameEn);
                                        Navigator.pushNamed(
                                            context, '/category_screen');
                                      },
                                      child: Align(
                                        alignment: SharedPrefController()
                                            .languageCode == 'en' ? Alignment
                                            .topRight : Alignment.topLeft,
                                        child: TextCustom(
                                            title: AppLocalizations.of(context)!
                                                .see_all,
                                            fontfamily: 'pop',
                                            fontweight: FontWeight.w500,
                                            size: SizeConfig.scaleTextFont(13),
                                            color: AppColors.TITLE_APP_BAR,
                                            align: TextAlign.start),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(8),),
                                Container(
                                  height: SizeConfig.scaleHeight(75),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ContanierItemCategory(title:
                                      SharedPrefController().languageCode == 'en'
                                          ? _homeController.data[0]
                                          .categories[index].nameEn
                                          :
                                      _homeController.data[0].categories[index]
                                          .nameAr
                                        ,
                                        image: _homeController.data[0]
                                            .categories[index].imageUrl,
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>
                                                  SubCategoriesScreen(
                                                    categoriesId: _homeController
                                                        .data[0].categories[index]
                                                        .id,)),);
                                        },);
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: SizeConfig.scaleWidth(22),);
                                    },
                                  ),
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(8),),
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
                                              .last_products,
                                          fontfamily: 'pop',
                                          fontweight: FontWeight.w700,
                                          size: SizeConfig.scaleTextFont(20),
                                          color: AppColors.TITLE_APP_BAR,
                                          align: TextAlign.start),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/last_product_screen');
                                      },
                                      child: Align(
                                        alignment: SharedPrefController()
                                            .languageCode == 'en' ? Alignment
                                            .topRight : Alignment.topLeft,
                                        child: TextCustom(
                                            title: AppLocalizations.of(context)!
                                                .see_all,
                                            fontfamily: 'pop',
                                            fontweight: FontWeight.w500,
                                            size: SizeConfig.scaleTextFont(13),
                                            color: AppColors.TITLE_APP_BAR,
                                            align: TextAlign.start),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(8),),
                                Container(
                                  height: 151,
                                  width: double.infinity,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    // _homeController.data[0].latestProducts.length,

                                    itemBuilder: (BuildContext context, int index) {
                                      return CardLastProduct(
                                        title: SharedPrefController()
                                            .languageCode == 'en' ?
                                        _homeController.data[0].latestProducts[index]
                                            .nameEn :
                                        _homeController.data[0].latestProducts[index]
                                            .nameEn,
                                        price: _homeController.data[0]
                                            .latestProducts[index].price,
                                        mainImage: _homeController.data[0]
                                            .latestProducts[index].imageUrl,
                                        quaitity: _homeController.data[0]
                                            .latestProducts[index].quantity,
                                        detiles: '',
                                        onPress: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(ProductId: _homeController.data[0]
                                              .latestProducts[index].id,)),);

                                        },);
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: SizeConfig.scaleWidth(8),);
                                    },
                                  ),
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(8),),
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
                                              .famous_products,
                                          fontfamily: 'pop',
                                          fontweight: FontWeight.w700,
                                          size: SizeConfig.scaleTextFont(20),
                                          color: AppColors.TITLE_APP_BAR,
                                          align: TextAlign.start),
                                    ),
                                    InkWell(
                                      onTap: () {

                                      },
                                      child: Align(
                                        alignment: SharedPrefController()
                                            .languageCode == 'en' ? Alignment
                                            .topRight : Alignment.topLeft,
                                        child: TextCustom(
                                            title: AppLocalizations.of(context)!
                                                .see_all,
                                            fontfamily: 'pop',
                                            fontweight: FontWeight.w500,
                                            size: SizeConfig.scaleTextFont(13),
                                            color: AppColors.TITLE_APP_BAR,
                                            align: TextAlign.start),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(8),),
                                Container(
                                  height: 151,
                                  width: double.infinity,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    // _homeController.data[0].latestProducts.length,

                                    itemBuilder: (BuildContext context, int index) {
                                      return CardLastProduct(
                                        title: SharedPrefController()
                                            .languageCode == 'en' ?
                                        _homeController.data[0].famousProducts[index]
                                            .nameEn :
                                        _homeController.data[0].famousProducts[index]
                                            .nameEn,
                                        price: _homeController.data[0]
                                            .famousProducts[index].price,
                                        mainImage: _homeController.data[0]
                                            .famousProducts[index].imageUrl,
                                        quaitity: _homeController.data[0]
                                            .famousProducts[index].quantity,
                                        detiles: '',
                                        onPress: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(ProductId: _homeController.data[0]
                                              .famousProducts[index].id,)),);
                                        },);
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: SizeConfig.scaleWidth(8),);
                                    },
                                  ),
                                ),
                              ],
                            ) :Center(child: Text('no data'));
                }
          ),

                          ]),
                    )
                )

        );
  }
}
