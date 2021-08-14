import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:electronic_e_commerce/api/product_api_controller.dart';
import 'package:electronic_e_commerce/api/rate_api_controller.dart';
import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/getx/product_getx_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/add_to_cart.dart';
import 'package:electronic_e_commerce/widgets/cart_counter.dart';
import 'package:electronic_e_commerce/widgets/counter_with_fav_btn.dart';
import 'package:electronic_e_commerce/widgets/price_pieces_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  Products Product;

  ProductDetailsScreen({required this.Product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with Helpers{
  late Future<ProductDetails> _futureProductDetails;
  late ProductDetails productsDetiles = ProductDetails();
  late ProductGetxController _productController;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  int length = 0;
  int numOfItems = 1;
  void initState() {
    // TODO: implement initState
    _productController = Get.put(ProductGetxController());
    super.initState();
    _futureProductDetails =
        ProductApiController().getProductDetiles(id: widget.Product.id);
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite=true;

    _productController.getProductDetails(id: widget.Product.id);

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.scaleWidth(15),
          right: SizeConfig.scaleWidth(15),
          top: SizeConfig.scaleHeight(45)),
      child: FutureBuilder<ProductDetails>(
          future: _futureProductDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey.shade500,
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              );
            } else if (snapshot.hasData) {
              productsDetiles = snapshot.data!;
              Color redColor=Colors.red;
              Color whiteColor=Colors.white;
              isFavorite= productsDetiles.isFavorite;
              Color color =
              isFavorite ? redColor: whiteColor;
              final List<String> image = [
                for (var i = 0; i < productsDetiles.images.length; i++)
                  productsDetiles.images[i].imageUrl
              ];

              final List<Widget> imageSliders = image
                  .map((item) => Container(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(item,
                                      fit: BoxFit.cover, width: 1000.0),
                                ],
                              )),
                        ),
                      ))
                  .toList();
              return SingleChildScrollView(
                child: Column(children: [
                  Row(
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: SizeConfig.scaleWidth(5),
                      ),
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
                                  Icons.search,
                                  color: AppColors.grey,
                                  size: SizeConfig.scaleHeight(24),
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(8),
                                ),
                                Expanded(
                                  child: TextField(
                                      onTap: () {},
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: AppLocalizations.of(context)!
                                            .search,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.scaleWidth(5),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(20),
                  ),
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
                          children: image.asMap().entries.map((entry) {
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
                                    color: (Theme.of(context).brightness ==
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
                  Column(
                    children: [
                      PriceAndPiecesItem(product: widget.Product),
                      SizedBox(height: SizeConfig.scaleHeight(10)),
                      Align(
                        alignment: SharedPrefController().languageCode == 'en'
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: TextCustom(
                          title: SharedPrefController().languageCode == 'en'
                              ? widget.Product.nameEn
                              : widget.Product.nameAr,
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
                              ? widget.Product.infoEn
                              : widget.Product.infoAr,
                          fontfamily: 'pop',
                          fontweight: FontWeight.w400,
                          size: SizeConfig.scaleTextFont(11),
                          align: TextAlign.start,
                          color: AppColors.SUB_TITLE_ON_BOARDING,
                        ),
                      ),
                      SizedBox(height: SizeConfig.scaleHeight(10)),
            Align(
              alignment:SharedPrefController().languageCode == 'en'? Alignment.centerLeft:Alignment.centerRight,
              child:    RatingBar.builder(
                initialRating:productsDetiles.productRate.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: SizeConfig.scaleHeight(23),
                itemPadding: EdgeInsets.only(right: 4),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating)async {
                 await RatingApiController().rate(context, product_id: productsDetiles.id, rate: rating);
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
                                padding:  EdgeInsets.symmetric(horizontal:SizeConfig.scaleWidth(8)),
                                child: Text(
                                  numOfItems.toString().padLeft(2, "0"),
                                  style: Theme.of(context).textTheme.headline6,
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
                          Container(
                            height: SizeConfig.scaleHeight(40),
                            width: SizeConfig.scaleWidth(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            child: IconButton(
                              onPressed: () {
    setState(() {
    if (isFavorite=true) {
      print(isFavorite);
    //  color=Colors.white;
      redColor = Colors.white;
      whiteColor = Colors.red;
      isFavorite=false;
      print(isFavorite);
    }else
    if (isFavorite) {
     // color=Colors.red;
      redColor = Colors.white;
      whiteColor = Colors.red;
      isFavorite=!isFavorite;
      print('rami1');

    }
    });

                              },
                              icon: Icon(
                                Icons.favorite,
                                color: color,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: SizeConfig.scaleHeight(10)),
                      // GetBuilder(
                      //   builder: (_) =>
            AddToCart(
                        product: widget.Product,
              onPressAddToCart: () {
                          checkCounter(productsDetiles);


                        },
              onPressToCart: () {
                          Navigator.pushNamed(context, '/cart_screen');
                      },
                      ),
         //   ),
                    ],
                  ),
                ]),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 80,
                    ),
                    Text(
                      'NO DATA',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                      ),
                    )
                  ],
                ),
              );
            }
          }),
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
/*
* import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:electronic_e_commerce/api/product_api_controller.dart';
import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/getx/product_getx_controller.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/add_to_cart.dart';
import 'package:electronic_e_commerce/widgets/counter_with_fav_btn.dart';
import 'package:electronic_e_commerce/widgets/price_pieces_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductDetailsScreen extends StatefulWidget {
  Products Product;

  ProductDetailsScreen({required this.Product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductGetxController _productController;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  int length=0;

  void initState() {
    // TODO: implement initState
    _productController =Get.put(ProductGetxController());
    super.initState();

  //  length= _productController.productsDetiles.images.length;
  }

  @override
  Widget build(BuildContext context) {
    _productController.getProductDetails(id: widget.Product.id);

    print('rami'+_productController.productsDetiles.price.toString());
    final List<String> image = [
      for (var i = 0;
          i < _productController.productsDetiles.images.length;
          i++)
        _productController.productsDetiles.images[i].imageUrl
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
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.scaleWidth(15),
          right: SizeConfig.scaleWidth(15),
          top: SizeConfig.scaleHeight(45)),
      child: GetX<ProductGetxController>(builder: (ProductGetxController controller) {
        return SingleChildScrollView(
                child: Column(children: [
                  Row(
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
                                  Icons.search,
                                  color: AppColors.grey,
                                  size: SizeConfig.scaleHeight(24),
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(8),
                                ),
                                Expanded(
                                  child: TextField(
                                      onTap: () {},
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: AppLocalizations.of(context)!
                                            .search,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.scaleWidth(5),
                      ),
                      Container(
                          height: 44.0,
                          width: 30.0,
                          child: new GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(
                              //     new MaterialPageRoute(
                              //         builder:(BuildContext context) =>
                              //         new CartItemsScreen()
                              //     )
                              // );
                            },
                            child: Stack(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: AppColors.MAIN_COLORE,
                                  ),
                                  onPressed: null,
                                ),
                                image.length == 0
                                    ? Container()
                                    : Positioned(
                                        child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                              top: 2.0,
                                              right: 4.0,
                                              child: Center(
                                                child: new Text(
                                                  image.length.toString(),
                                                  style: new TextStyle(
                                                      color:
                                                          AppColors.MAIN_COLORE,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )),
                                        ],
                                      )),
                              ],
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.scaleHeight(20),
                  ),
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
                          children: image.asMap().entries.map((entry) {
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
                                    color: (Theme.of(context).brightness ==
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
                  Column(
                    children:[

                      PriceAndPiecesItem(product: widget.Product),
                      SizedBox(height: SizeConfig.scaleHeight(10)),

                      TextCustom(
                title: SharedPrefController().languageCode=='en'?widget.Product.nameEn:widget.Product.nameAr,
                fontfamily: 'pop',
                fontweight: FontWeight.w600,
                size: SizeConfig.scaleTextFont(14),
                align: TextAlign.center,
                color: AppColors.TITLE_ON_BOARDING,
              ),
                      SizedBox(height: SizeConfig.scaleHeight(5)),
                      TextCustom(
                        title: SharedPrefController().languageCode=='en'?widget.Product.infoEn:widget.Product.infoAr,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w400,
                        size: SizeConfig.scaleTextFont(11),
                        align: TextAlign.center,
                        color: AppColors.SUB_TITLE_ON_BOARDING,
                      ),

                      SizedBox(height: SizeConfig.scaleHeight(10)),

                      CounterWithFavBtn(color: Colors.red,),

                      SizedBox(height: SizeConfig.scaleHeight(10)),
                      AddToCart(product: widget.Product, onPress: () {

                      },)
                    ],
                  ),
                ]),
              );
      }),
    ));
  }
}
*/
