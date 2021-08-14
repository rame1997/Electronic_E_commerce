import 'package:electronic_e_commerce/api/product_api_controller.dart';
import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/user.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class UserGetxController extends GetxController {
  static UserGetxController get to => Get.find();

  bool isLoggedIn = false;
  late User user;

  @override
  void onInit() {
    if (SharedPrefController().loggedIn) user = SharedPrefController().getUser();
    super.onInit();
  }
  Future<bool> changePassword(BuildContext context, {required String currentPassword,required String newPassword}) async {
    return await UserApiController().changePassword(context, currentPassword: currentPassword, newPassword: newPassword);
  }
  Future<bool> updateProfile(BuildContext context, {required String name, required String gender,required int city_id}) async {
    return await UserApiController().updateProfile(context, name: name, gender: gender,city_id: city_id);
  }
}