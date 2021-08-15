import 'package:electronic_e_commerce/models/categories.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/slider.dart';

class Home {
 late bool status;
 late String message;
 late List<Data> list;

  Home.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      list=<Data>[];
        json['data'].forEach((v) {
          list.add(Data.fromJson(v) );
        });
    }
  }

}

class Data {
 late List<SliderList> slider;
 late List<Categories> categories;
 late List<Products> latestProducts;
 late List<Products> famousProducts;


  Data.fromJson(Map<String, dynamic> json) {
    if (json['slider'] != null) {
      slider = <SliderList>[];
      json['slider'].forEach((v) {
        slider.add(new SliderList.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['latest_products'] != null) {
      latestProducts = <Products>[];
      json['latest_products'].forEach((v) {
        latestProducts.add(new Products.fromJson(v));
      });
    }
    if (json['famous_products'] != null) {
      famousProducts = <Products>[];
      json['famous_products'].forEach((v) {
        famousProducts.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slider != null) {
      data['slider'] = this.slider.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.latestProducts != null) {
      data['latest_products'] =
          this.latestProducts.map((v) => v.toJson()).toList();
    }
    if (this.famousProducts != null) {
      data['famous_products'] =
          this.famousProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}





