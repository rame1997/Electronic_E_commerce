import 'package:electronic_e_commerce/api/favorite_api_controller.dart';
import 'package:electronic_e_commerce/api/product_api_controller.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductGetxController extends GetxController {
  final ProductApiController productApiController = ProductApiController();
  final FavoriteApiController favoriteApiController = FavoriteApiController();
  RxList<Products> products = <Products>[].obs;
  Rx<ProductDetails> productsDetiles = ProductDetails().obs;
  RxList<Products> favoriteProducts = <Products>[].obs;
  RxBool loading = true.obs;

  static ProductGetxController get to => Get.find();
  @override
  void onInit() {
    getFavoriteProduct();
    super.onInit();
  }
  Future<void> getProduct({required int id}) async {
    loading.value = true;
    products.value = await productApiController.getProduct(id: id);
    loading.value = false;
    update();
  }
  Future<void> getProductDetails({required int id}) async {
    loading.value = true;
    productsDetiles.value= await productApiController.getProductDetiles(id: id) ;
    loading.value = false;
    update();
  }
  Future<void> getFavoriteProduct() async {
    loading.value = true;
    favoriteProducts.value = await favoriteApiController.getProduct();
    loading.value = false;
    update();
  }

  Future<void> removeFavoriteProduct(BuildContext context,int id) async {
    await favoriteApiController.addFavorite(context, product_id: id);
    favoriteProducts.clear();
  }
}