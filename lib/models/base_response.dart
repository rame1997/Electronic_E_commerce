import 'package:electronic_e_commerce/models/card.dart';
import 'package:electronic_e_commerce/models/question.dart';

import 'address.dart';
import 'city.dart';
import 'order.dart';

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
      if(T==CardModel){
        json['list'].forEach((v) {
          list.add(CardModel.fromJson(v) as T);
        });
      }
      if(T==Address){
        json['list'].forEach((v) {
          list.add(Address.fromJson(v) as T);
        });
      }
      if(T==Order){
        json['list'].forEach((v) {
          list.add(Order.fromJson(v) as T);
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
