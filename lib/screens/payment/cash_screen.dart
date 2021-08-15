import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CashScreen extends StatefulWidget {
String image;

CashScreen({required this.image});

  @override
  _CashScreenState createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(widget.image),
          SizedBox(
            height: SizeConfig.scaleHeight(15),
          ),
          TextCustom(
              title: AppLocalizations.of(context)!.thank,
              fontfamily: 'pop',
              fontweight: FontWeight.w700,
              size: SizeConfig.scaleTextFont(30),
              color: AppColors.TITLE_ON_BOARDING,
              align: TextAlign.center),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    );
  }
}