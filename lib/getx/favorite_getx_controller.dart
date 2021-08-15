import 'package:electronic_e_commerce/api/favorite_api_controller.dart';
import 'package:electronic_e_commerce/api/product_api_controller.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class FavoriteGetxController extends GetxController {
  final FavoriteApiController favoriteApiController = FavoriteApiController();
  RxList<Products> favoriteProducts = <Products>[].obs;
  static FavoriteGetxController get to => Get.find();
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> getFavoriteProduct() async {
    favoriteProducts.value = await favoriteApiController.getProduct();
    update();
  }
  Future<void> removeFavoriteProduct(BuildContext context,int id) async {
     await favoriteApiController.addFavorite(context, product_id: id);
     favoriteProducts.clear();
  }
}