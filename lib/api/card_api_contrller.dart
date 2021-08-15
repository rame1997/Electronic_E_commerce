import 'dart:convert';
import 'dart:io';

import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/base_response.dart';
import 'package:electronic_e_commerce/models/card.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';
class CardApiController with ApiMixin, Helpers {
  Future<bool> cardRequests(BuildContext context,
      {required String holder_name, required String card_number, required String exp_date,
        required int cvv, required String type}) async {
    var response = await http.post(getUrl(ApiSettings.CONTACT_REQUESTES),
        body: {'holder_name': holder_name, 'card_number': card_number,
          'exp_date': exp_date,'cvv': cvv.toString(),
          'type': type,}, headers: {
          HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
          'X-Requested-With':'XMLHttpRequest',
        }
    );

    if (isSuccessRequest(response.statusCode)) {
      showSnackBar(
          context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode != 500) {
      showSnackBar(
          context,
          message: jsonDecode(response.body)['message'],
          error: false);
    } else {
      handleServerError(context);
    }

    return false;
  }
  Future<List<CardModel>> getCard() async {
    var url = Uri.parse(ApiSettings.PAYMENT_CARDS);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+ SharedPrefController().token,
      'X-Requested-With':'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      BaseResponse<CardModel> baseResponse = BaseResponse.fromJson(jsonDecode(response.body));
      return baseResponse.list;
      //     return citiesResponse.list;
    }

    return [];
  }
  Future<bool> deleteCard(BuildContext context,{required int id}) async {
    var url = Uri.parse(ApiSettings.PAYMENT_CARDS+'/$id');
    var response = await http.delete(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
      'X-Requested-With': 'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      showSnackBar(
          context,
          message: jsonDecode(response.body)['message'],
          error: false);
      return true;
    }
    return false;
  }
}


