import 'package:electronic_e_commerce/models/card.dart';

import 'address.dart';

class OrderDetiles {
  late int id;
  late int total;
  late String date;
  late String paymentType;
  late String status;
  late int storeId;
  late int userId;
  late int addressId;
  late int paymentCardId;
  late int productsCount;
  late List<Products> products;
  late Address address;
  late CardModel paymentCard;


  OrderDetiles();

  OrderDetiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    paymentType = json['payment_type'];
    status = json['status'];
    storeId = json['store_id'];
    userId = json['user_id'];
    addressId = json['address_id'];
    paymentCardId = json['payment_card_id'];
    productsCount = json['products_count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    address =
    (json['address'] != null ? new Address.fromJson(json['address']) : null)!;
    paymentCard = (json['payment_card'] != null
        ? new CardModel.fromJson(json['payment_card'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['date'] = this.date;
    data['payment_type'] = this.paymentType;
    data['status'] = this.status;
    data['store_id'] = this.storeId;
    data['user_id'] = this.userId;
    data['address_id'] = this.addressId;
    data['payment_card_id'] = this.paymentCardId;
    data['products_count'] = this.productsCount;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.paymentCard != null) {
      data['payment_card'] = this.paymentCard.toJson();
    }
    return data;
  }
}

class Products {
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late int price;
  late int quantity;
  late double overalRate;
  late int subCategoryId;
  late int orderQuantity;
  late double productRate;
  late int? offerPrice;
  late bool isFavorite;
  late String imageUrl;
  late Pivot pivot;



  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    infoEn = json['info_en'];
    infoAr = json['info_ar'];
    price = json['price'];
    quantity = json['quantity'];
    overalRate = json['overal_rate'];
    subCategoryId = json['sub_category_id'];
    orderQuantity = json['order_quantity'];
    productRate = json['product_rate'];
    offerPrice = json['offer_price'];
    isFavorite = json['is_favorite'];
    imageUrl = json['image_url'];
    pivot = (json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['info_en'] = this.infoEn;
    data['info_ar'] = this.infoAr;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['overal_rate'] = this.overalRate;
    data['sub_category_id'] = this.subCategoryId;
    data['order_quantity'] = this.orderQuantity;
    data['product_rate'] = this.productRate;
    data['offer_price'] = this.offerPrice;
    data['is_favorite'] = this.isFavorite;
    data['image_url'] = this.imageUrl;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  late int orderId;
  late int productId;


  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    return data;
  }
}





