class ProductDetails {
  late int id;
  late String nameEn;
  late String nameAr;
  late String infoEn;
  late String infoAr;
  late int price=0;
  late int quantity;
  late int overalRate;
  late int subCategoryId;
  late num productRate;
  late int? offerPrice;
  late bool isFavorite;
  late String imageUrl;
  late List<Images> images=[];
  late SubCategory subCategory;


  ProductDetails();

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    nameEn = json['name_en']??'';
    nameAr = json['name_ar']??'';
    infoEn = json['info_en']??'';
    infoAr = json['info_ar']??'';
    price = json['price']??0;
    quantity = json['quantity']??0;
    overalRate = json['overal_rate']??0;
    subCategoryId = json['sub_category_id']??0;
    productRate = json['product_rate']??0;
    offerPrice = json['offer_price']??0;
    isFavorite = json['is_favorite']??0;
    imageUrl = json['image_url']??'';
    if (json['images'] != null) {
      images=<Images>[];
      json['images'].forEach((v) {
        images.add(Images.fromJson(v) );
      });
    }
    subCategory = (json['sub_category'] != null
        ? new SubCategory.fromJson(json['sub_category']??[])
        : null)!;
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
    data['product_rate'] = this.productRate;
    data['offer_price'] = this.offerPrice;
    data['is_favorite'] = this.isFavorite;
    data['image_url'] = this.imageUrl;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory.toJson();
    }
    return data;
  }
}

class Images {
  late int id;
  late String url;
  late String imageUrl;


  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class SubCategory {
  late int id;
  late String nameEn;
  late String nameAr;
  late int categoryId;
  late String image;
  late String imageUrl;


  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    categoryId = json['category_id'];
    image = json['image'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    return data;
  }
}