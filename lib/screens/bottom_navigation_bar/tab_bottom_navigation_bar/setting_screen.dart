import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/getx/language_getx_controller.dart';
import 'package:electronic_e_commerce/getx/user_getx_controller.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/setting_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserGetxController controller = Get.put(UserGetxController());
  @override
  void initState() {
    controller.user;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
        decoration: BoxDecoration(color: Colors.white),
    child: Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: TextCustom(
      title: AppLocalizations.of(context)!.setting,
      fontfamily: 'pop',
      fontweight: FontWeight.w600,
      size: SizeConfig.scaleTextFont(17),
      align: TextAlign.center,
      color: Colors.black,
    ),
      leading: InkWell(
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.MAIN_COLORE,
          size: SizeConfig.scaleHeight(20),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),

    ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: SizeConfig.scaleHeight(15),
            ),


            SizedBox(height: SizeConfig.scaleHeight(10)),
            Divider(
              endIndent: SizeConfig.scaleWidth(45),
              indent: SizeConfig.scaleWidth(45),
              color: AppColors.grey,
              thickness: SizeConfig.scaleHeight(1),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.scaleWidth(16),
                  right: SizeConfig.scaleWidth(16),
                  top: SizeConfig.scaleHeight(18)),
              child: Column(
                children: [
                  SettingItem(title: AppLocalizations.of(context)!
                      .language, subTitle: AppLocalizations.of(context)!.selected_language + SharedPrefController().languageCode == 'en'
                      ? 'AR'
                      : 'EN', icon:Icons.language ,index:1 ,onTap:(){
                    changeLang();
                  } ,),
                  SettingItem(title: AppLocalizations.of(context)!.profile, subTitle:AppLocalizations.of(context)!.update_your_profile, icon:Icons.person ,index:2 ,onTap:(){
                    navigateToProfileScreen();
                  } ,),
                  SettingItem(title:AppLocalizations.of(context)!.about, subTitle: AppLocalizations.of(context)!.describe_the_company, icon:Icons.info ,index:3 ,onTap:(){
                    navigateToAboutScreen();
                  } ,),
                  SettingItem(title: AppLocalizations.of(context)!.addresses, subTitle: AppLocalizations.of(context)!.add_addresses, icon:Icons.place_outlined ,index:4 ,onTap:(){
                    navigateToAddressScreen();
                  } ,),
                  SettingItem(title: AppLocalizations.of(context)!.card, subTitle: AppLocalizations.of(context)!.add_card, icon:Icons.credit_card ,index:4 ,onTap:(){
                    navigateToCardScreen();
                  } ,),
                  SettingItem(title: AppLocalizations.of(context)!.contact_us, subTitle: AppLocalizations.of(context)!.contact_us_message, icon:Icons.contact_support ,index:5 ,onTap:(){
                    navigateToContantScreen();
                  } ,),
                  SettingItem(title: AppLocalizations.of(context)!.change_password, subTitle: AppLocalizations.of(context)!.change_password_message, icon:Icons.password ,index:6 ,onTap:(){
                    navigateToChangeScreen();
                  } ,),
                  SettingItem(title:AppLocalizations.of(context)!. logout, subTitle: AppLocalizations.of(context)!.logout_message, icon:Icons.logout ,index:7 ,onTap:()async{
                   await logout();
                  } ,),
                ],
              )
            ),
          ],
        ),
      ),
    )) );
  }
  void changeLang() {
    String newLanguageCode =
    SharedPrefController().languageCode == 'en' ? 'ar' : 'en';
    print(newLanguageCode);
    LanguageGetxController.to.changeLanguage(newLanguageCode);
  }
  void navigateToChangeScreen() {
    Navigator.pushReplacementNamed(context, '/change_password_screen');
  }
  void navigateToProfileScreen() {
    Navigator.pushNamed(context, '/profile_screen');
  }
  void navigateToContantScreen() {
    Navigator.pushNamed(context, '/contant_screen');
  }
  void navigateToAboutScreen() {
    Navigator.pushNamed(context, '/about_screen');
  }
  void navigateToAddressScreen() {
    Navigator.pushNamed(context, '/address_option_screen');
  }
  void navigateToCardScreen() {
    Navigator.pushNamed(context, '/card_option_screen');
  }
  Future logout() async {
    bool loggedOut = await UserApiController().logout(context);
    if(loggedOut){
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }
}
