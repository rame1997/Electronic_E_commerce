class Cart {
  late int id;
  late int product_id;
  late int quantity;
  late double price;
  late int user_id;
  late String nameEn;
  late String nameAr;

  Cart();
  static const TABLE_NAME = 'cart';

  Cart.fromMap(Map<String, dynamic> rowMap)  {
    id = rowMap['id'];
    product_id = rowMap['product_id'];
    quantity = rowMap['quantity'];
    price = rowMap['price'];
    user_id = rowMap['user_id'];
    nameEn = rowMap['nameEn'];
    nameAr = rowMap['nameAr'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['product_id'] = product_id;
    map['quantity'] = quantity;
    map['price'] = price;
    map['user_id'] = user_id;
    map['nameEn'] = nameEn;
    map['nameAr'] = nameAr;
    return map;
  }
}
