import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                            cardNumberDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                            ),
                            expiryDateDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Card Holder',
                            ),
                            onCreditCardModelChange: onCreditCardModelChange,
                          ),
                          SizedBox(height: SizeConfig.scaleHeight(18),),
                          Padding(
                            padding: EdgeInsets.only(
                          left: SizeConfig.scaleWidth(8),
                        right: SizeConfig.scaleWidth(8),),
                            child: button(
                              text: AppLocalizations.of(context)!.validate,
                              color: AppColors.MAIN_COLORE,
                              onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                  print('valid!');
                                } else {
                                  print('invalid!');
                                }
                        //      await performUpdateProfile();
                              },
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
