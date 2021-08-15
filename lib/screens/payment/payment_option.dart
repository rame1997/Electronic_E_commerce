import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/payment_option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'card_screen.dart';
import 'cash_screen.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({Key? key}) : super(key: key);

  @override
  _PaymentOptionScreenState createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
        appBar: buildAppBar(context),
        body:
            Padding(
              padding:  EdgeInsets.only(left: SizeConfig.scaleWidth(16),right: SizeConfig.scaleWidth(16),top: SizeConfig.scaleHeight(8),bottom: SizeConfig.scaleHeight(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PaymentOptionItem(onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CashScreen(image:'images/verification.svg' ,)));
        }, title: AppLocalizations.of(context)!.cash, image: 'images/verification.svg',),

                  PaymentOptionItem(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardScreen(),));
                  }, title: AppLocalizations.of(context)!.electronic_payment, image: 'images/on_boarding2.svg',),
                ],
              ),
            ),
          )
    );

  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.payment_option,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
