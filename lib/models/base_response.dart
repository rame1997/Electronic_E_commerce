import 'package:electronic_e_commerce/models/question.dart';

import 'city.dart';

class BaseResponse<T> {
 late  bool status;
  late String message;
  late List<T> list;


  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list'] != null) {
      list=<T>[];
      if(T==City){
        json['list'].forEach((v) {
          list.add(City.fromJson(v) as T);
        });

    }
      if(T==Question){
        json['list'].forEach((v) {
          list.add(Question.fromJson(v) as T);
        });

      }
  }
        }
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> city = new Map<String, dynamic>();
  //   city['status'] = this.status;
  //   city['message'] = this.message;
  //   city['list'] = this.list.map((v) => v.toJson()).toList();
  //
  //   return city;
  // }
}
