class Quintity {
  late int id;
  late  int idProduct;
  late  int quintity;


  Quintity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduct = json['url'];
    quintity = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.idProduct;
    data['image_url'] = this.quintity;
    return data;
  }
}