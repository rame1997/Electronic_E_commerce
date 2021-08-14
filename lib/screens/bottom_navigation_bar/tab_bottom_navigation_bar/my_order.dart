import 'package:electronic_e_commerce/getx/product_getx_controller.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/widgets/cart_body.dart';
import 'package:electronic_e_commerce/widgets/check_out_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderProductsScreen extends StatefulWidget {
  const MyOrderProductsScreen({Key? key}) : super(key: key);

  @override
  _MyOrderProductsScreenState createState() => _MyOrderProductsScreenState();
}

class _MyOrderProductsScreenState extends State<MyOrderProductsScreen> {
 late ProductGetxController controller;
 late Products products;
  void initState() {
    // TODO: implement initState
    controller = Get.put(ProductGetxController());
    controller.getProduct(id: 105);
    products=controller.products[0];
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(products: products),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "8 items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
