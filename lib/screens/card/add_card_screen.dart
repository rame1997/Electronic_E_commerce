import 'package:electronic_e_commerce/getx/card_getx_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/card.dart';
import 'package:electronic_e_commerce/models/city.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/drop_down_city_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> with Helpers{
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  City dropDownTypePayment = City.typePayment[0];
  int selectedTypePayment = 0;
  late CardGetxController controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    controller=Get.put(CardGetxController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: buildAppBar(context),
            body: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.scaleWidth(4),
                    right: SizeConfig.scaleWidth(4),
                    top: SizeConfig.scaleHeight(8),
                    bottom: SizeConfig.scaleHeight(8)),
                child: Column(children: <Widget>[
                  CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[

                          CreditCardForm(
                            formKey: formKey,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumber: cardNumber,
                            cvvCode: cvvCode,
                            cardHolderName: cardHolderName,
                            expiryDate: expiryDate,
                            themeColor: Colors.blue,
                            cardNumberDecoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.number,
                              hintText: 'XXXX XXXX XXXX XXXX',
                            ),
                            expiryDateDecoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.expired_date,
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.cvv,
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration:  InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.card_holder,
                            ),

                            onCreditCardModelChange: onCreditCardModelChange,
                          ),

                          SizedBox(height: SizeConfig.scaleHeight(18),),
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.scaleWidth(15),
                              right: SizeConfig.scaleWidth(15),),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    DropDowm(
                                      list: City.typePayment,
                                      onChanged: (City? typePayment) {
                                        setState(() {
                                          dropDownTypePayment = typePayment!;
                                          selectedTypePayment = typePayment.id;
                                        });
                                      },
                                      dropDownValue: dropDownTypePayment,
                                      hint: AppLocalizations.of(context)!.gender,
                                    ),
                                  ],
                                ),
                                SizedBox(height: SizeConfig.scaleHeight(18),),
                                button(
                                  text: AppLocalizations.of(context)!.validate,
                                  color: AppColors.MAIN_COLORE,
                                  onPressed: () async{
                                    if (formKey.currentState!.validate()) {
                                      await save();
                                      print('valid!');
                                    } else {
                                      print('invalid!');
                                    }
                                    //      await performUpdateProfile();
                                  },
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
                ]))));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.credit_card,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
  Future<void> save() async {
    print(dropDownTypePayment.nameEn);
    CardModel card = CardModel();
    card.holderName=cardHolderName;
    card.cardNumber=cardNumber;
    card.expDate=expiryDate;
    card.cvv=cvvCode;
    card.type=dropDownTypePayment.nameEn;

    bool status = await CardGetxController.to.createCard(context, card: card);
    if (status) {
      showSnackBar(context, message: 'Added done', error: false);
      Navigator.pop(context);
    } else {
    }
  }
  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
