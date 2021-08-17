import 'dart:convert';
import 'dart:io';

import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/address.dart';
import 'package:electronic_e_commerce/models/base_response.dart';
import 'package:electronic_e_commerce/models/card.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';
class AddressApiController with ApiMixin, Helpers {
  Future<bool> addressRequests(BuildContext context,
      {required String name, required String info, required String contact_number,
        required int city_id}) async {
    var response = await http.post(getUrl(ApiSettings.ADDRESS),
        body: {'name': name, 'info': info,
          'contact_number': contact_number,'city_id': city_id.toString(), 'lat':'',
          'lang': '',
          }, headers: {
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
  Future<List<Address>> getAddress() async {
    var url = Uri.parse(ApiSettings.ADDRESS);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+ SharedPrefController().token,
      'X-Requested-With':'XMLHttpRequest'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      BaseResponse<Address> baseResponse = BaseResponse.fromJson(jsonDecode(response.body));
      return baseResponse.list;
      //     return citiesResponse.list;
    }

    return [];
  }
  Future<bool> deleteAddress(BuildContext context,{required int id}) async {
    var url = Uri.parse(ApiSettings.ADDRESS+'/$id');
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
  Future<bool> updateAddress({required BuildContext context, required Address address}) async {
    var response = await http.put(
      getUrl(ApiSettings.ADDRESS + '/${address.id}'),
      headers: {
        HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: {
        'name': address.name,
        'info': address.info,
        'contact_number': address.contactNumber,
        'city_id': address.cityId.toString(),
        'lat': address.lat.toString(),
        'lang': address.lang.toString(),
      },
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


