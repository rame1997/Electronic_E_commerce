import 'package:electronic_e_commerce/api/product_api_controller.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:get/get.dart';


class ProductGetxController extends GetxController {
  final ProductApiController productApiController = ProductApiController();
  RxList<Products> products = <Products>[].obs;
 // RxList<ProductDetails> productsDetiles = <ProductDetails>[].obs;
   late ProductDetails productsDetiles=ProductDetails();
  static ProductGetxController get to => Get.find();
  @override
  void onInit() {
    super.onInit();
  }
  Future<void> getProduct({required int id}) async {
    products.value = await productApiController.getProduct(id: id);
    update();
  }
  Future<void> getProductDetails({required int id}) async {
    productsDetiles= await productApiController.getProductDetiles(id: id) ;
    update();
  }
}