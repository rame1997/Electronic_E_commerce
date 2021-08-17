

class City {
  late int id;
  late String nameEn;
  late String nameAr;

  City({required this.id, required this.nameEn, required this.nameAr});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    return data;
  }
  static List<City>gender=[City(id: 1,nameEn: 'M',nameAr:'ذكر' ),City(id: 2,nameEn: 'F',nameAr:'انثي' ),
  ];
  static List<City>typePayment=[City(id: 1,nameEn: 'Master',nameAr:'ماستر كارت' ),City(id: 2,nameEn: 'Visa',nameAr:'فيزا' ),
  ];
}

/*class City{
  int id;
  String name_ar;
  String name_en;

  City(this.id, this.name_en, this.name_ar);
  static List<City>city=[
    City(1,'Gaza','غزة'),
    City(2,'Deir Al-Balah','دير البلح'),
    City(3,'Khanyounis','خانيونس'),
    City(4,'Al Nosyrat','النصيرات'),
    City(5,'Al Borayj','البريج'),
    City(6,'Al Mghazi','المغازي'),
    City(7,'Rafah','رفح'),
    City(8,'Al Zwayda','الزوايدة'),
    City(9,'Jbalya','جباليا'),
    City(10,'Beit Lahya','بيت لاهيا'),
    City(11,'Biet Hanoon','بيت حانون'),
  ];
  static List<City>gender=[City(1,'M','ذكر'),
  City(2,'F','انثي')];

}*/
