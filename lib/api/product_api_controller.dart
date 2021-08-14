import 'dart:convert';
import 'dart:io';
import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class ProductApiController with ApiMixin, Helpers {

  Future<List<Products>> getProduct({required int id}) async {
    var url = Uri.parse(ApiSettings.PRODUCT+'/$id');
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Products> product = data.map((e) => Products.fromJson(e)).toList();
      return product;
    }
    return [];
  }

  Future<ProductDetails> getProductDetiles({required int id}) async {
    ProductDetails product=ProductDetails();
    var url = Uri.parse(ApiSettings.PRODUCT_DETILES+'/$id');
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var jsonObject = jsonResponse['object'];
      ProductDetails product = ProductDetails.fromJson(jsonObject);
      return product;
    }
    return product;
  }
}