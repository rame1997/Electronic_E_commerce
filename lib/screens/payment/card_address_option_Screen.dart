import 'dart:convert';

import 'package:electronic_e_commerce/api/order_api_controller.dart';
import 'package:electronic_e_commerce/getx/address_getx_controller.dart';
import 'package:electronic_e_commerce/getx/card_getx_controller.dart';
import 'package:electronic_e_commerce/getx/cart_getx_controller.dart';
import 'package:electronic_e_commerce/getx/order_getx_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/address.dart';
import 'package:electronic_e_commerce/models/card.dart';
import 'package:electronic_e_commerce/models/city.dart';
import 'package:electronic_e_commerce/models/order_create.dart';
import 'package:electronic_e_commerce/models/order_create.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/drop_down_address_item.dart';
import 'package:electronic_e_commerce/widgets/drop_down_card_item.dart';
import 'package:electronic_e_commerce/widgets/drop_down_city_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CardAddressOptionScreen extends StatefulWidget {

  @override
  _CardAddressOptionScreenState createState() => _CardAddressOptionScreenState();
}

class _CardAddressOptionScreenState extends State<CardAddressOptionScreen> with Helpers{
 //  CardGetxController controllerCard=Get.put(CardGetxController());
 //  AddressGetxController controllerAddress=Get.put(AddressGetxController());
   CartGetxController controllerCart=Get.put(CartGetxController());
  CardModel? dropDownCard;
  Address? dropDownAddress;
  int selectedIdCard = 0;
  int selectedIdAddress = 0;
  List<CartCreate> cartCreate=[];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(cartCreate.length);
    for(int i=0;i<controllerCart.cart.length;i++) {
      cartCreate.add(CartCreate(product_id: controllerCart.cart.value[i].product_id,
          quantity: controllerCart.cart.value[i].quantity));
    }
    print(cartCreate.length);

    return SafeArea(
        child: Scaffold(
            appBar: buildAppBar(context),
            body: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.scaleWidth(16),
                    right: SizeConfig.scaleWidth(16),
                    top: SizeConfig.scaleHeight(8),
                    bottom: SizeConfig.scaleHeight(8)),
                child: Column(children: <Widget>[
                  Align(
                    alignment: SharedPrefController()
                        .languageCode == 'en'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: TextCustom(
                        title: AppLocalizations.of(context)!
                            .card,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w700,
                        size: SizeConfig.scaleTextFont(16),
                        color: AppColors.TITLE_APP_BAR,
                        align: TextAlign.start),
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10),),

                  GetX<CardGetxController> (
                      builder: (CardGetxController controller){
                      return controller.loading.value
                            ? Center(child: CircularProgressIndicator())
                            : controller.cards.isNotEmpty
                            ?
                  Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.scaleWidth(2),
              vertical: SizeConfig.scaleWidth(2),
            ),
            height: SizeConfig.scaleHeight(56),
            width: double.infinity,
            child: DropDowmCard(list:controller.cards.value, onChanged: (CardModel? cardModel) {
                setState(() {
                  dropDownCard = cardModel!;
                  selectedIdCard = cardModel.id;
                });


            }, dropDownValue: dropDownCard, hint: 'Card',)
                  ):Center(child: Text('No data'));
  }),
                  SizedBox(height: SizeConfig.scaleHeight(10),),

                  Align(
                    alignment: SharedPrefController()
                        .languageCode == 'en'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: TextCustom(
                        title: AppLocalizations.of(context)!
                            .addresses,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w700,
                        size: SizeConfig.scaleTextFont(16),
                        color: AppColors.TITLE_APP_BAR,
                        align: TextAlign.start),
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(10),),

                  GetX<AddressGetxController> (
                      builder: (AddressGetxController controller){
                        return controller.loading.value
                            ? Center(child: CircularProgressIndicator())
                            : controller.addresses.isNotEmpty
                            ?
                        Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.scaleWidth(2),
                              vertical: SizeConfig.scaleWidth(2),
                            ),
                            height: SizeConfig.scaleHeight(56),
                            width: double.infinity,
                            child: DropDowmAddress(list:controller.addresses.value, onChanged: (Address? address) {
                              setState(() {
                                dropDownAddress = address!;
                                selectedIdAddress = address.id;
                              });


                            }, dropDownValue: dropDownAddress, hint: 'Address',)
                        ):Text('data');
                      }),
                  SizedBox(height: SizeConfig.scaleHeight(60)),
                  button(
                    text: AppLocalizations.of(context)!.add,
                    color: AppColors.MAIN_COLORE,
                    onPressed: () async{
                     await performAddOrder();
                    },
                  ),
                ]))));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.card_address_option,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
  Future<void> performAddOrder() async {
    late OrderCreate order;
    late var finalJson;

      finalJson = OrderCreate(card_id: 0, cart_create: [], payment_type: '', address_id: 0).encondeToJson(cartCreate);
      print(finalJson);

    order = OrderCreate(cart_create:[], address_id: selectedIdAddress, payment_type: 'Online', card_id: selectedIdCard);
    bool status = await OrderApiController().orderRequests(context, cart: cart, payment_type:  order.payment_type, address_id:  order.address_id, card_id: order.card_id);
    if (status) {
      showSnackBar(context, message: 'Added Order', error: true);
      Navigator.pushNamed(context, '/home_screen');
    } else {
      showSnackBar(context, message: 'Please, check data', error: true);
    }
   }
   String get cart {
     List<Map<String, dynamic>> items = [];
     CartGetxController.to.cart.map((element) => items.add({'product_id': element.product_id, 'quantity': element.quantity})).toList();
     return jsonEncode(items);
   }
}
