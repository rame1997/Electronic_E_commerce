class Categories {
  late int id;
  late String nameEn;
  late String nameAr;
  late String image;
  late String imageUrl;
  late int? productsCount;
  late String? subCategoriesCount;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    imageUrl = json['image_url'];
    productsCount = json['products_count'];
    subCategoriesCount = json['sub_categories_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['image'] = this.image;
    data['image_url'] = this.imageUrl;
    data['products_count']=productsCount;
    data['sub_categories_count']=subCategoriesCount;
    return data;
  }
}