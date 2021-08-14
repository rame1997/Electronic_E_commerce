
import 'dart:convert';
import 'dart:io';

import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/base_response.dart';
import 'package:electronic_e_commerce/models/city.dart';
import 'package:electronic_e_commerce/models/question.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class QuestionApiController with ApiMixin, Helpers {
  Future<List<Question>> getQuestion() async {
    var url = Uri.parse(ApiSettings.Question);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+ SharedPrefController().token,
      'X-Requested-With':'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      BaseResponse<Question> baseResponse = BaseResponse.fromJson(jsonDecode(response.body));
      return baseResponse.list;
      //     return citiesResponse.list;
    }

    return [];
  }
}