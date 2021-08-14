import 'dart:convert';
import 'dart:io';

import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';
class ContantApiController with ApiMixin, Helpers {
  Future<bool> contactRequests(BuildContext context,
      {required String subject, required String message}) async {
    var response = await http.post(getUrl(ApiSettings.CONTACT_REQUESTES),
        body: {'subject': subject, 'message': message,}, headers: {
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
          error: true);
    } else {
      handleServerError(context);
    }

    return false;
  }

}


