
 import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:electronic_e_commerce/api/favorite_api_controller.dart';
import 'package:electronic_e_commerce/api/product_api_controller.dart';
import 'package:electronic_e_commerce/api/rate_api_controller.dart';
import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/getx/cart_getx_controller.dart';
import 'package:electronic_e_commerce/getx/product_getx_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/add_to_cart.dart';
import 'package:electronic_e_commerce/widgets/counter_with_fav_btn.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int ProductId;

  ProductDetailsScreen({required this.ProductId});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with Helpers{
  late CartGetxController cartGetxController;
  late ProductGetxController productGetxController;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductGetxController.to.getProductDetails(id: widget.ProductId);
    });
    cartGetxController = Get.put(CartGetxController());
    productGetxController=Get.put(ProductGetxController());
    super.initState();
  }
 final CarouselController _controller = CarouselController();
int _current=0;
 int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.scaleWidth(15),
          right: SizeConfig.scaleWidth(15),
          top: SizeConfig.scaleHeight(45)),
      child:  SingleChildScrollView(
            child: Column(children: [
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
              GetX<ProductGetxController>(
                  builder: (ProductGetxController controller) {
                    final List<String> image = [
                      for (var i = 0;
                      i < controller.productsDetiles.value.images.length;
                      i++)
                        controller.productsDetiles.value.images[i].imageUrl
                    ];
                    final List<Widget> imageSliders = image
                        .map((item) => Container(
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
                        .toList();
                    return controller.loading.value ? Center(
                        child: CircularProgressIndicator())
                        :Column(
  children: [

    SizedBox(
      height: SizeConfig.scaleHeight(8),
    ),
    Column(
      children: [
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: image
                    .asMap()
                    .entries
                    .map((entry) {
                  return GestureDetector(
                    onTap: () {
                      _controller.animateToPage(entry.key);
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
                              .brightness ==
                              Brightness.dark
                              ? Colors.white
                              : Colors.black)
                              .withOpacity(
                              _current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: SizeConfig.scaleHeight(8),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.price),
                  SizedBox(height: SizeConfig.scaleHeight(5)),
                  TextCustom(
                    title: controller.productsDetiles.value
                        .offerPrice != null
                        ? '\$' +
                        controller.productsDetiles.value.price
                            .toString()
                        : '\$' +
                        controller.productsDetiles.value.offerPrice
                            .toString() + ' sale',
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
                    title: controller.productsDetiles.value.quantity
                        .toString() + 'Pieses',
                    fontfamily: 'pop',
                    fontweight: FontWeight.w700,
                    size: SizeConfig.scaleTextFont(12),
                    align: TextAlign.center,
                    color: AppColors.TITLE_ON_BOARDING,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.scaleHeight(10)),
        Align(
          alignment: SharedPrefController().languageCode == 'en'
              ? Alignment.topLeft
              : Alignment.topRight,
          child: TextCustom(
            title: SharedPrefController().languageCode == 'en'
                ? controller.productsDetiles.value.nameEn
                : controller.productsDetiles.value.nameAr,
            fontfamily: 'pop',
            fontweight: FontWeight.w600,
            size: SizeConfig.scaleTextFont(14),
            align: TextAlign.center,
            color: AppColors.TITLE_ON_BOARDING,
          ),
        ),
        SizedBox(height: SizeConfig.scaleHeight(5)),
        Align(
          alignment: SharedPrefController().languageCode == 'en'
              ? Alignment.topLeft
              : Alignment.topRight,
          child: TextCustom(
            title: SharedPrefController().languageCode == 'en'
                ? controller.productsDetiles.value.infoEn
                : controller.productsDetiles.value.infoAr,
            fontfamily: 'pop',
            fontweight: FontWeight.w400,
            size: SizeConfig.scaleTextFont(11),
            align: TextAlign.start,
            color: AppColors.SUB_TITLE_ON_BOARDING,
          ),
        ),
        SizedBox(height: SizeConfig.scaleHeight(10)),
        Align(
          alignment: SharedPrefController().languageCode == 'en'
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: RatingBar.builder(
            initialRating: controller.productsDetiles.value
                .productRate.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: SizeConfig.scaleHeight(23),
            itemPadding: EdgeInsets.only(right: 4),
            itemBuilder: (context, _) =>
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
            onRatingUpdate: (rating) async {
              await RatingApiController().rate(context,
                  product_id: controller.productsDetiles.value.id,
                  rate: rating);
              print(rating);
            },
          ),
        ),

        SizedBox(height: SizeConfig.scaleHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                buildOutlineButton(
                  icon: Icons.remove,
                  press: () {
                    if (numOfItems > 1) {
                      setState(() {
                        numOfItems--;
                      });
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.scaleWidth(8)),
                  child: Text(
                    numOfItems.toString().padLeft(2, "0"),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6,
                  ),
                ),
                buildOutlineButton(
                    icon: Icons.add,
                    press: () {
                      setState(() {
                        numOfItems++;
                      });
                    }),
              ],
            ),
            FavoriteButton(
              isFavorite: controller.productsDetiles.value.isFavorite,
              valueChanged: (_isFavorite) {
                if (_isFavorite) {
                  FavoriteApiController().addFavorite(context,
                      product_id: controller.productsDetiles.value
                          .id);
                } else {
                  FavoriteApiController().addFavorite(context,
                      product_id: controller.productsDetiles.value
                          .id);
                }
              },
            ),

          ],
        ),


      ],
    ),
  ],
);
        }  ),    SizedBox(height: SizeConfig.scaleHeight(10)),


 AddToCart(
  onPressAddToCart: () {

    if (checkCounter(ProductGetxController.to.productsDetiles.value)) {
      ProductGetxController.to.productsDetiles.value.quantity-numOfItems;
CartGetxController.to.add(ProductGetxController.to.productsDetiles.value, numOfItems);
    }
  },
  onPressToCart: () {
    Navigator.pushNamed(context, '/cart_screen');
  },
),

            ]),
          )


    ));
  }
      SizedBox buildOutlineButton({required IconData icon, required Function() press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
  bool checkCounter(ProductDetails productsDetiles){
    if(productsDetiles.quantity>=numOfItems){
      productsDetiles.quantity-numOfItems;
      showSnackBar(
          context,
          message:AppLocalizations.of(context)!.added_to_cart,
          error: false);
     return true;
    }
    showSnackBar(
        context,
        message:AppLocalizations.of(context)!.message_counter_product,
        error: true);
    return false;
  }
}
