import 'package:electronic_e_commerce/getx/cart_getx_controller.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'cart_card.dart';


class Body extends StatefulWidget {
  List<ProductDetails> products;
  List<int> quitity;

  Body({required this.products,required this.quitity});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CartGetxController controller = Get.put(CartGetxController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: SizeConfig.scaleHeight(20)),
      child: ListView.builder(
        itemCount:widget.products.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(1.toString()),//demoCarts[index].product.id.toString()
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {

               // demoCarts.removeAt(index);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  Icon(Icons.shopping_cart),
                ],
              ),
            ),
            child: CartCard(Product: widget.products[index], qunitity: widget.quitity[index], onPress:(){
              controller.del(index);
            },),//cart: demoCarts[index]
          ),
        ),
      ),
    );
  }
}