
import 'dart:convert';
import 'dart:io';

import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class FavoriteApiController with ApiMixin, Helpers {
  Future<bool> addFavorite(BuildContext context,
      {required int product_id}) async {
    var response = await http.post(getUrl(ApiSettings.ADD_FAVARITE_PRODUCT),
      body: {'product_id': product_id.toString()},headers: {
        HttpHeaders.authorizationHeader:'Bearer '+ SharedPrefController().token,
        'X-Requested-With': 'XMLHttpRequest',
      },);
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      showSnackBar(
          context,
          message: jsonDecode(response.body)['message'],
          error: false);
      return true;
    } else if (response.statusCode != 500) {
      showSnackBar(
          context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    handleServerError(context);
    return false;
  }
  Future<List<Products>> getProduct() async {
    var url = Uri.parse(ApiSettings.READ_FAVARITE_PRODUCT);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
      'Accept': 'application/json'
    });
    if (isSuccessRequest(response.statusCode)) {
      var data = jsonDecode(response.body)['list'] as List;
      List<Products> product = data.map((e) => Products.fromJson(e)).toList();
      return product;
    }
    return [];
  }

}