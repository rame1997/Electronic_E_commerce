import 'package:electronic_e_commerce/api/city_api_controller.dart';
import 'package:electronic_e_commerce/api/home_api_controller.dart';
import 'package:electronic_e_commerce/models/categories.dart';
import 'package:electronic_e_commerce/models/home.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/slider.dart';
import 'package:get/get.dart';

class HomeGetxController extends GetxController{
  RxList<Data> data = <Data>[].obs;
  RxList<SliderList> slider = <SliderList>[].obs;
  RxList<Categories> categorie = <Categories>[].obs;
  RxList<Products> product = <Products>[].obs;
  RxBool loading = true.obs;

  static HomeGetxController get to => Get.find();

  @override
  void onInit() {
    getHome();
    super.onInit();
  }



  Future<void> getHome() async {
    loading.value = true;
    data.value = await HomeApiController().getHome();
    loading.value = false;
    data.refresh();
  }
  Future<void> getSlider() async {
    loading.value = true;
    slider.value = await data[0].slider;
    loading.value = false;
    slider.refresh();
  }
  Future<void> getCategories() async {
    loading.value = true;
    categorie.value = await data[0].categories;
    loading.value = false;
    categorie.refresh();
  }
  Future<void> getLastProduct() async {
    loading.value = true;
    product.value = await data[0].latestProducts;
    loading.value = false;
    product.refresh();
  }

}