
import 'dart:convert';
import 'dart:io';

import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/home.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class HomeApiController with ApiMixin, Helpers {
  Future<List<Data>> getHome() async {
    var url = Uri.parse(ApiSettings.HOME);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
      'Accept':'application/json',
      'X-Requested-With':'XMLHttpRequest'
    },);

    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var jsonObject = jsonResponse['data'];

      Data data = Data.fromJson(jsonObject);
      print('rami'+[data].toString());

      //  print(data.slider[0].imageUrl);

      return [data];
      //return data.list;
    }

    return [];
  }
}