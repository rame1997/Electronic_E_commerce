import 'package:electronic_e_commerce/api/city_api_controller.dart';
import 'package:electronic_e_commerce/api/home_api_controller.dart';
import 'package:electronic_e_commerce/models/categories.dart';
import 'package:electronic_e_commerce/models/home.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:get/get.dart';

class HomeGetxController extends GetxController{
  RxList<Data> data = <Data>[].obs;
  RxList<Slider> slider = <Slider>[].obs;
  RxList<Categories> categorie = <Categories>[].obs;
  RxList<Products> product = <Products>[].obs;
  static HomeGetxController get to => Get.find();

  @override
  void onInit() {
    getHome();
    getSlider();
    getCategories();
    getLastProduct();
    super.onInit();
  }

  @override
  void onClose() {
    data.clear();
    super.onClose();
  }
  Future<void> getHome() async {
    data.value = await HomeApiController().getHome();
    data.refresh();
  }
  Future<void> getSlider() async {
    slider.value = await data[0].slider;
    slider.refresh();
  }
  Future<void> getCategories() async {
    categorie.value = await data[0].categories;
    categorie.refresh();
  }
  Future<void> getLastProduct() async {
    product.value = await data[0].latestProducts;
    product.refresh();
  }

}