import 'package:electronic_e_commerce/api/favorite_api_controller.dart';
import 'package:electronic_e_commerce/api/rate_api_controller.dart';
import 'package:electronic_e_commerce/getx/cart_getx_controller.dart';
import 'package:electronic_e_commerce/getx/order_getx_controller.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDetailsScreen extends StatefulWidget {
int idOreder;

OrderDetailsScreen({required this.idOreder});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late OrderGetxController orderGetxController;
  late CartGetxController cartGetxController;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await OrderGetxController.to.getOrderDetails(id: widget.idOreder);
    });
    orderGetxController = Get.put(OrderGetxController());
    cartGetxController = Get.put(CartGetxController());

    super.initState();
  }

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
                GetX<OrderGetxController>(
                    builder: (OrderGetxController controller) {
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
                                height: SizeConfig.scaleHeight(240),
                                child: Image.network(controller.orderDetiles.value.products[0].imageUrl,fit: BoxFit.cover,width: double.infinity,
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
                                          title: controller.orderDetiles.value.total.toString(),
                                          fontfamily: 'pop',
                                          fontweight: FontWeight.w700,
                                          size: SizeConfig.scaleTextFont(12),
                                          align: TextAlign.center,
                                          color: AppColors.MAIN_COLORE,
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
                                          title:controller.orderDetiles.value.productsCount
                                              .toString() + 'Pieses',
                                          fontfamily: 'pop',
                                          fontweight: FontWeight.w700,
                                          size: SizeConfig.scaleTextFont(12),
                                          align: TextAlign.center,
                                          color: AppColors.MAIN_COLORE,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(AppLocalizations.of(context)!.status),
                                        SizedBox(height: SizeConfig.scaleHeight(5)),
                                        TextCustom(
                                          title:controller.orderDetiles.value.status,
                                          fontfamily: 'pop',
                                          fontweight: FontWeight.w700,
                                          size: SizeConfig.scaleTextFont(12),
                                          align: TextAlign.center,
                                          color: AppColors.MAIN_COLORE,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(AppLocalizations.of(context)!.electronic_payment),
                                        SizedBox(height: SizeConfig.scaleHeight(5)),
                                        TextCustom(
                                          title:controller.orderDetiles.value.paymentType,
                                          fontfamily: 'pop',
                                          fontweight: FontWeight.w700,
                                          size: SizeConfig.scaleTextFont(12),
                                          align: TextAlign.center,
                                          color: AppColors.MAIN_COLORE,
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
                                      ? controller.orderDetiles.value.products[0].nameEn
                                      : controller.orderDetiles.value.products[0].nameAr,
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
                                      ? controller.orderDetiles.value.products[0].infoEn
                                      : controller.orderDetiles.value.products[0].infoAr,
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
                                  initialRating: controller.orderDetiles.value.products[0].
                                      productRate.toDouble(),
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
                                        product_id: controller.orderDetiles.value.products[0].id,
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
                                      Text(AppLocalizations.of(context)!.addresses),
                                      SizedBox(width: SizeConfig.scaleWidth(10)),
                                      TextCustom(
                                          title: SharedPrefController()
                                              .languageCode == 'en'
                                              ? controller.orderDetiles.value.address.city.nameEn
                                              : controller.orderDetiles.value.address.city.nameAr,
                                          fontfamily: 'pop',
                                          fontweight: FontWeight.w600,
                                          size: SizeConfig.scaleTextFont(14),
                                          color: AppColors.MAIN_COLORE,
                                          align: TextAlign.start),
                                    ],
                                  ),
                                  FavoriteButton(
                                    isFavorite: controller.orderDetiles.value.products[0].isFavorite,
                                    valueChanged: (_isFavorite) {
                                      if (_isFavorite) {
                                        FavoriteApiController().addFavorite(context,
                                            product_id: controller.orderDetiles.value.products[0].
                                                id);
                                      } else {
                                        FavoriteApiController().addFavorite(context,
                                            product_id:controller.orderDetiles.value.products[0]
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




              ]),
            )


        ));
  }

}
