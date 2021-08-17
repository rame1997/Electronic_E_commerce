import 'package:electronic_e_commerce/getx/card_getx_controller.dart';
import 'package:electronic_e_commerce/screens/card/update_card_screen.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/address_option_item.dart';
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
  int tot=0;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await CardGetxController.to.getCards();
    });
    super.initState();
  }
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
    Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.scaleWidth(16),
          right: SizeConfig.scaleWidth(16),
          top: SizeConfig.scaleHeight(18),bottom: SizeConfig.scaleHeight(24)
      ),
      child: ListView.builder(
        itemCount: controller.cards.value.length,
        itemBuilder: (BuildContext context,int index){
          tot=index+1;
          return AddressOptionItem(title: AppLocalizations.of(context)!.card_number+tot.toString(), subTitle: AppLocalizations.of(context)!. card_number_message, icon: Icons.credit_card, index: index, onTapEdit: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCardScreen(card: controller.cards[index],)),);
          }, onTapDelete: () {
            controller.deleteCard(context, cardId:  controller.cards.value[index].id);
          },);

        },
      ),
    ): Center(child: Text('no data'));
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
          child: Icon(Icons.add,color: AppColors.MAIN_COLORE,size: SizeConfig.scaleHeight(30),),
        )
      ],
    );
  }
}
