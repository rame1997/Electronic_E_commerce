import 'dart:convert';

import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';

mixin ApiMixin implements Helpers {
  Uri getUrl(String url) {
    return Uri.parse(url);
  }

  bool isSuccessRequest(int statusCode){
    return statusCode < 400;
  }

  void handleServerError(BuildContext context){
    showSnackBar(context,message: 'Unable to perform your request now!',error: true);
  }

  void showMessage(BuildContext context, Response response){
    showSnackBar(
         context,
        message: jsonDecode(response.body)['message'],
        error: true);
  }
}
