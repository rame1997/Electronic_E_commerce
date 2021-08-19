import 'package:electronic_e_commerce/getx/order_getx_controller.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/cart_body.dart';
import 'package:electronic_e_commerce/widgets/check_out_card.dart';
import 'package:electronic_e_commerce/widgets/order_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../order_details_screen.dart';

class MyOrderProductsScreen extends StatefulWidget {
  const MyOrderProductsScreen({Key? key}) : super(key: key);

  @override
  _MyOrderProductsScreenState createState() => _MyOrderProductsScreenState();
}

class _MyOrderProductsScreenState extends State<MyOrderProductsScreen> {
  OrderGetxController controller = Get.put(OrderGetxController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await OrderGetxController.to.getOrder();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body:
        GetX<OrderGetxController>(
            builder: (OrderGetxController controller) {
              return controller.loading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.order.isNotEmpty
                  ?Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.scaleWidth(16),
                    right: SizeConfig.scaleWidth(16),
                    top: SizeConfig.scaleHeight(18)),
                    child: ListView.separated(
                itemCount:controller.order.length,
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
                      child:OrderCard(order: controller.order.value[index], onPress: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsScreen(idOreder: controller.order[index].id,)),);
                      }, index: index,),//cart: demoCarts[index]
                    ),
                ), separatorBuilder: (BuildContext context, int index) {
                  return  Divider(
                    endIndent: SizeConfig.scaleWidth(45),
                    indent: SizeConfig.scaleWidth(45),
                    color: AppColors.grey,
                    thickness: SizeConfig.scaleHeight(1),
                  );
                    },
              ),
                  ):Center(child: Text('no data'));

            }),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.my_order,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
