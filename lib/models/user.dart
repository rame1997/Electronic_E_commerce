class User {
  late int id;
  late String name;
  late String? email;
  late String mobile;
  late String gender;
  late bool active;
  late bool verified;
  late int cityId;
  late int storeId;
  late String token;
  late String tokenType;
  late String refreshToken;

  User(); // late City city;



  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    active = json['active'];
    verified = json['verified'];
    cityId = json['city_id'];
    storeId = json['store_id'];
    token = json['token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    // city = (json['city'] != null ? new City.fromJson(json['city']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['active'] = this.active;
    data['verified'] = this.verified;
    data['city_id'] = this.cityId;
    data['store_id'] = this.storeId;
    data['token'] = this.token;
    data['token_type'] = this.tokenType;
    data['refresh_token'] = this.refreshToken;
    // if (this.city != null) {
    //   data['city'] = this.city.toJson();
    // }
    return data;
  }
}

// class City {
//   late int id;
//   late String nameEn;
//   late String nameAr;
//
//   City({required this.id, required this.nameEn, required this.nameAr});
//
//   City.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nameEn = json['name_en'];
//     nameAr = json['name_ar'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name_en'] = this.nameEn;
//     data['name_ar'] = this.nameAr;
//     return data;
//   }
// }