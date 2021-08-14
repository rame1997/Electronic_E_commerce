import 'dart:convert';
import 'dart:io';
import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/categories.dart';
import 'package:electronic_e_commerce/models/sub_categories.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class CategoriesApiController with ApiMixin, Helpers{

  Future<List<Categories>> getCategory() async {
    var url = Uri.parse(ApiSettings.Categorie);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Categories> categories = data.map((e) => Categories.fromJson(e)).toList();
      return categories;
    }
    return [];
  }

  Future<List<SubCategories>> getSubCategory({required int id}) async {
    var response = await http.get(getUrl(ApiSettings.Categorie + '/$id'),headers: {
      HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<SubCategories> subCategories = data.map((e) => SubCategories.fromJson(e)).toList();
      return subCategories;
    }
    return [];
  }
}
