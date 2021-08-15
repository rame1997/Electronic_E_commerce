import 'package:electronic_e_commerce/getx/card_api_controller.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class CardOptionScreen extends StatefulWidget {
  const CardOptionScreen({Key? key}) : super(key: key);

  @override
  _CardOptionScreenState createState() => _CardOptionScreenState();
}

class _CardOptionScreenState extends State<CardOptionScreen> {

  CardGetxController controller = Get.put(CardGetxController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: buildAppBar(context),
            body: GetX<CardGetxController> (
            builder: (CardGetxController controller){
    return controller.loading.value
    ? Center(child: CircularProgressIndicator())
        : controller.cards.isNotEmpty
    ?
            SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.scaleWidth(16),
                      right: SizeConfig.scaleWidth(16),
                      top: SizeConfig.scaleHeight(18)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [


                      ]),
                )): Center(child: Text('no data'));
            },
            ),
        ),);
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.card,
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/add_card_screen');
          },
          child: Icon(Icons.add,color: AppColors.MAIN_COLORE,size: SizeConfig.scaleHeight(20),),
        )
      ],
    );
  }
}
