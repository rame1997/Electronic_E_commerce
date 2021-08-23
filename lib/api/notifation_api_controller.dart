import 'dart:convert';
import 'dart:io';
import 'package:electronic_e_commerce/mixins/api_mixin.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/base_response.dart';
import 'package:electronic_e_commerce/models/notafiction.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'api_settings.dart';

class NotifationApiController with ApiMixin, Helpers {

  Future<List<Notifation>> getNotifation() async {
    var url = Uri.parse(ApiSettings.Notifications);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader:'Bearer '+SharedPrefController().token,
      'Accept':'application/json'
    });
    if (isSuccessRequest(response.statusCode)) {
      var jsonResponse = jsonDecode(response.body);
      BaseResponse<Notifation> baseResponse = BaseResponse.fromJson(jsonDecode(response.body));
      return baseResponse.list;
      //     return citiesResponse.list;
    }

    return [];
  }
}