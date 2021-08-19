import 'dart:convert';
import 'dart:io';

import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/base_response.dart';
import 'package:electronic_e_commerce/models/order.dart';
import 'package:electronic_e_commerce/models/order_create.dart';
import 'package:electronic_e_commerce/models/order_detiles.dart';
import 'package:electronic_e_commerce/models/quintity.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_settings.dart';

class OrderApiController with ApiMixin, Helpers {

  Future<List<Order>> getProduct() async {
    var url = Uri.parse(ApiSettings.ORDER);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      BaseResponse<Order> baseResponse = BaseResponse.fromJson(jsonDecode(response.body));
      return baseResponse.list;
    }
    return [];
  }
  Future<bool> orderRequests(BuildContext context,
      {required var cart, required String payment_type, required int address_id,
        required int card_id}) async {
    var response = await http.post(getUrl(ApiSettings.ORDER),
        body: {'cart': cart, 'payment_type': payment_type,
          'address_id': address_id.toString(),
          'card_id': card_id.toString()}, headers: {
          HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
          'X-Requested-With':'XMLHttpRequest',
        }
    );

    if (isSuccessRequest(response.statusCode)) {
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
    } else {
      handleServerError(context);
    }

    return false;
  }

  Future<OrderDetiles> getProductDetiles({required int id}) async {
    OrderDetiles orderDetiles=OrderDetiles();
    var url = Uri.parse(ApiSettings.ORDER+'/$id');
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var jsonObject = jsonResponse['data'];
      OrderDetiles orderDetiles = OrderDetiles.fromJson(jsonObject);
      return orderDetiles;
    }
    return orderDetiles;
  }
}