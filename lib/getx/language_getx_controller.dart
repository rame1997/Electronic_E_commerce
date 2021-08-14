import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:get/get.dart';

class LanguageGetxController extends GetxController{

  RxString languageCode = 'ar'.obs;

  static LanguageGetxController get to => Get.find();

  @override
  void onInit() {
    languageCode.value = SharedPrefController().languageCode;
    super.onInit();
  }

  void changeLanguage(String newLanguageCode) {
    languageCode.value = newLanguageCode;
    SharedPrefController().setLanguage(newLanguageCode);
  }
}