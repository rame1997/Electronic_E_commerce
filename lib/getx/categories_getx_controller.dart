import 'package:electronic_e_commerce/api/categories_api_controller.dart';
import 'package:electronic_e_commerce/models/categories.dart';
import 'package:electronic_e_commerce/models/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CategoryGetxController extends GetxController {
  final CategoriesApiController categoryApiController = CategoriesApiController();
  RxList<Categories> categories = <Categories>[].obs;
  RxList<SubCategories> subCategories = <SubCategories>[].obs;

  static CategoryGetxController get to => Get.find();

  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    categories.value = await categoryApiController.getCategory();
    update();
  }


  Future<void> getSubCategories({required int id}) async {
    subCategories.value = await categoryApiController.getSubCategory(id: id);
    update();
  }
}