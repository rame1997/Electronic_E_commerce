import 'dart:convert';
import 'dart:io';

import 'package:electronic_e_commerce/api/api_settings.dart';
import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/register.dart';
import 'package:electronic_e_commerce/models/user.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserApiController with ApiMixin, Helpers {
  Future<bool> login(BuildContext context,
      {required String mobile, required String password,required var fcm_token,}) async {
    var response = await http.post(getUrl(ApiSettings.LOGIN),
        body: {'mobile': mobile, 'password': password, 'fcm_token': fcm_token});
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      var jsonObject = jsonResponse['data'];
      User user = User.fromJson(jsonObject);
      await SharedPrefController().save(user);

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

  Future<bool> register(BuildContext context,
      {required String mobile, required String password,
        required String name, required String gender,
        required int cityId, required String storeApiKey}) async {
    var response = await http.post(getUrl(ApiSettings.REGISTER),
        body: {'name': name,'mobile': mobile,
          'password': password, 'gender': gender,
          'STORE_API_KEY': storeApiKey, 'city_id': cityId.toString()});

    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      Resigter resigter = Resigter.fromJson(jsonResponse);
      await SharedPrefController().savecode(resigter.code);
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

  Future<bool> active(BuildContext context,
      {required String mobile, required String code}) async {
    var response = await http.post(getUrl(ApiSettings.ACTIVATE),
        body: {'mobile': mobile,'code': code,});

    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
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

  Future<bool> logout(BuildContext context) async {
    var response = await http.get(
      getUrl(ApiSettings.LOGOUT),
      headers: {
        HttpHeaders.authorizationHeader:'Bearer '+ SharedPrefController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'lang':SharedPrefController().languageCode
      },
    );
    if (response.statusCode == 200 ||
        response.statusCode == 401 ||
        response.statusCode == 403) {
      await SharedPrefController().logout();
      return true;
    } else {
      handleServerError(context);
    }
    return false;
  }
  Future<bool> forgetPassword(BuildContext context,
      {required String mobile}) async {
    var response = await http
        .post(getUrl(ApiSettings.FORGET), body: {'mobile': mobile} ,headers: {
    'lang':SharedPrefController().languageCode
    },);
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      Resigter resigter = Resigter.fromJson(jsonResponse);
      await SharedPrefController().savecode(resigter.code);
      print(SharedPrefController().code);
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
  Future<bool> resetPassword(BuildContext context,
      {required String mobile,
        required String code,
        required String password,required String password_confirmation}) async {
    print('the result'+mobile+code+password+password_confirmation);
    var response = await http.post(
        getUrl(ApiSettings.RESET),
      body: {
        'mobile': mobile,
        'code': code,
        'password': password,
        'password_confirmation': password_confirmation,
      },headers: {
    'lang':SharedPrefController().languageCode
    }
    );

    print(response.body);
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
          error: true);
        } else {
      handleServerError(context);
    }

    return false;
  }
  Future<bool> changePassword(BuildContext context, {required String currentPassword, required String newPassword}) async {
    var response = await http.post(
        getUrl(ApiSettings.CHANGE_PASSWORD),
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPassword,
        },
        headers: {
          HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
          'Accept':'application/json',
          'lang':'en'
        }    );
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
          error: true);
    } else {
      handleServerError(context);
    }

    return false;
  }
  Future<bool> updateProfile(BuildContext context,
      {required String name, required String gender,required int city_id}) async {
    var response = await http.post(getUrl(ApiSettings.UPDATE_PROFILE),
        body: {'name': name, 'gender': gender,'city_id': city_id.toString()}, headers: {
          HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
          'Accept':'application/json',
          'lang':'en'
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
          error: true);
    } else {
      handleServerError(context);
    }

    return false;
  }


  Future<bool> FcmNotifcation(BuildContext context,
      {required var fcmToken}) async {

    var response = await http.post(getUrl(ApiSettings.REFRESH_FCM_TOKEN),
        headers: {
          'lang':SharedPrefController().languageCode,
        },
        body: {'fcm_token': fcmToken});
    if (isSuccessRequest(response.statusCode)) {
      return true;
    } else if (response.statusCode != 500) {
      showSnackBar(
          context,
          message: "error token",
          error: true);
    }
    handleServerError(context);
    return false;
  }
}


