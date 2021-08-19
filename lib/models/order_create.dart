class OrderCreate{
  List<CartCreate> cart_create;
 String payment_type;
 int address_id;
 int card_id;

  OrderCreate(
      {required this.cart_create, required this.payment_type, required this.address_id, required this.card_id});

  List encondeToJson(List<CartCreate> list) {
    List jsonList = [];
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }
}


class CartCreate{
  late int product_id;
  late int quantity;

  CartCreate({required this.product_id, required this.quantity});
  CartCreate.fromJson(Map<String, dynamic> json) {
    product_id = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.product_id;
    data['quantity'] = this.quantity;
    return data;
  }
}