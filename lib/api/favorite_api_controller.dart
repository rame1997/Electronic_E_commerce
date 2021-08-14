//
// import 'package:electronic_e_commerce/mixins/api_mixin.dart';
// import 'package:electronic_e_commerce/mixins/helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'api_settings.dart';
//
// class FavoriteApiController with ApiMixin, Helpers {
//   Future<bool> login(BuildContext context,
//       {required String mobile, required String password}) async {
//     var response = await http.post(getUrl(ApiSettings.RATE),
//         body: {'mobile': mobile, 'password': password});
//     if (isSuccessRequest(response.statusCode)) {
//       var jsonResponse = jsonDecode(response.body);
//       var jsonObject = jsonResponse['data'];
//       User user = User.fromJson(jsonObject);
//       await SharedPrefController().save(user);
//
//       return true;
//     } else if (response.statusCode != 500) {
//       showSnackBar(
//           context,
//           message: jsonDecode(response.body)['message'],
//           error: true);
//     }
//     handleServerError(context);
//     return false;
//   }
// }