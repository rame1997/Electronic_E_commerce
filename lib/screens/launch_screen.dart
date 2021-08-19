import 'package:electronic_e_commerce/getx/address_getx_controller.dart';
import 'package:electronic_e_commerce/getx/card_getx_controller.dart';
import 'package:electronic_e_commerce/getx/cart_getx_controller.dart';
import 'package:electronic_e_commerce/getx/city_getx_controller.dart';
import 'package:electronic_e_commerce/getx/home_getx_controller.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
       Get.put(CityGetxController());
       Get.put(HomeGetxController());
    Get.put(CardGetxController());
    Get.put(AddressGetxController());
    Get.put(CartGetxController());
    Future.delayed(Duration(seconds: 2), () {
      String route = SharedPrefController().loggedIn ? '/bottom_navigation_bar_screen' : '/on_boarding_screen';
      Navigator.pushReplacementNamed(context, route);

    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.GRADIENT_BEGIN_COLOR,
                AppColors.MAIN_COLORE
              ]),
        ),
        child: TextCustom(
            title: AppLocalizations.of(context)!.name_app,
            fontfamily: 'pop',
            fontweight: FontWeight.w700,
            size: SizeConfig.scaleTextFont(30),
            color: Colors.white,
            align: TextAlign.center),

        ),
    );
  }
}
