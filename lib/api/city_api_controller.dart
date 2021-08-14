
import 'dart:convert';

import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/base_response.dart';
import 'package:electronic_e_commerce/models/city.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class CityApiController with ApiMixin, Helpers {
  Future<List<City>> getCity() async {
    var url = Uri.parse(ApiSettings.CITY);
    var response = await http.get(url,headers: {
      'Accept':'application/json'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      BaseResponse<City> baseResponse = BaseResponse.fromJson(jsonDecode(response.body));
      return baseResponse.list;
      //     return citiesResponse.list;
    }

    return [];
  }
}