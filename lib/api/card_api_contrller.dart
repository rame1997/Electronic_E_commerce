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
        required String cvv, required String type}) async {
    String number=card_number.replaceAll(new RegExp(r"\s+"), "");
   List<String>exp= exp_date.split('/');
    var response = await http.post(getUrl(ApiSettings.PAYMENT_CARDS),
        body: {'holder_name': holder_name, 'card_number': int.parse(number).toString(),
          'exp_date': '20'+exp[1]+'-'+exp[0]+'-'+'01','cvv': cvv,
          'type': type,}, headers: {
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
  Future<List<CardModel>> getCard() async {
    print('rami');
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
  Future<bool> updateCard({required BuildContext context,required int id,required String holder_name, required String card_number, required String exp_date,
    required String cvv, required String type}) async {
    String number=card_number.replaceAll(new RegExp(r"\s+"), "");
    List<String>exp= exp_date.split('/');
    var response = await http.put(
      getUrl(ApiSettings.PAYMENT_CARDS + '/${id}'),
      headers: {
        HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
        'X-Requested-With': 'XMLHttpRequest'
      },
        body: {'holder_name': holder_name, 'card_number': int.parse(number).toString(),
          'exp_date': '20'+exp[1]+'-'+exp[0]+'-'+'01','cvv': cvv,
          'type': type,}
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
      return false;
    }
    handleServerError(context);
    return false;
  }
}


