import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:electronic_e_commerce/widgets/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'active_account_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> with Helpers{
  late TextEditingController _mobileTextEditingController;

  String? _mobileError;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileTextEditingController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobileTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: TextCustom(
              title: AppLocalizations.of(context)!.forgot_password_title,
              fontfamily: 'pop',
              fontweight: FontWeight.w400,
              size: SizeConfig.scaleTextFont(16),
              color: AppColors.TITLE_ON_BOARDING,
              align: TextAlign.right),
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
    body: Padding(
    padding: EdgeInsets.only(
    right: SizeConfig.scaleWidth(16),
    left: SizeConfig.scaleWidth(16),
    top: SizeConfig.scaleHeight(16)),
    child: Column(
    children: [
      TextCustom(
          title: AppLocalizations.of(context)!.forget_message,
          fontfamily: 'pop',
          fontweight: FontWeight.w700,
          size: SizeConfig.scaleTextFont(25),
          color: AppColors.TITLE_APP_BAR,
          align: TextAlign.start),
      SizedBox(height: SizeConfig.scaleHeight(16)),

      TextCustom(
          title: AppLocalizations.of(context)!.enter_mobile,
          fontfamily: 'pop',
          fontweight: FontWeight.w500,
          size: SizeConfig.scaleTextFont(16),
          color: AppColors.SUB_TITLE_ON_BOARDING,
          align: TextAlign.start),

      SizedBox(height: SizeConfig.scaleHeight(16)),

      TextFiled((){},obscureText: false,hint:AppLocalizations.of(context)!.mobile  ,textEditingController: _mobileTextEditingController,textInputType:TextInputType.number ,maxLength: 9, error: _mobileError,),
      SizedBox(
        height: SizeConfig.scaleHeight(24),
      ),
      button(
        text: AppLocalizations.of(context)!.send,
        color: AppColors.MAIN_COLORE,
        onPressed: () async{
          await performForget();
        },
      ),

    ]

      ),
    )));
  }
  Future performForget() async{
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_mobileTextEditingController.text.isNotEmpty) {
      return true;
    }
    checkErrors();
    showSnackBar(context,message: 'Please, enter required data',error: true);
    return false;
  }

  Future register()async {
    bool forget = await UserApiController().forgetPassword(context,
        mobile: _mobileTextEditingController.text);


    if (forget) {
      navigateToActive();
    }
  }

  void navigateToActive() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) =>ActiveScreen(phoneNumber:_mobileTextEditingController.text , code: SharedPrefController().code, create: false,))
    );
    print('rami');
  }


  void checkErrors() {
    setState(() {
      _mobileError =
      _mobileTextEditingController.text.isEmpty ? 'Enter Mobile Number' : '';

    });
  }
}
