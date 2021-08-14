
import 'dart:convert';
import 'dart:io';

import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class RatingApiController with ApiMixin, Helpers {
  Future<bool> rate(BuildContext context,
      {required int product_id, required num rate}) async {
    var response = await http.post(getUrl(ApiSettings.RATE),
        body: {'product_id': product_id.toString(), 'rate': rate.toString()},headers: {
        HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'lang': 'en'
        });
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
}