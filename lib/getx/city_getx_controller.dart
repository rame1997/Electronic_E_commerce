import 'package:electronic_e_commerce/api/city_api_controller.dart';
import 'package:electronic_e_commerce/models/city.dart';
import 'package:get/get.dart';

class CityGetxController extends GetxController{
  RxList<City> city = <City>[].obs;
  static CityGetxController get to => Get.find();

  @override
  void onInit() {
    getCity();
    super.onInit();
  }

  @override
  void onClose() {
    city.clear();
    super.onClose();
  }
  Future<void> getCity() async {
    city.value = await CityApiController().getCity();
    city.refresh();
  }


}