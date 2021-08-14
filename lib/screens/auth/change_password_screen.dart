import 'package:electronic_e_commerce/getx/user_getx_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:electronic_e_commerce/widgets/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with Helpers{
  late TextEditingController _oldPasswordEditingController;
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _newPasswordConfirmationEditingController;


  @override
  void initState() {
    super.initState();
    _oldPasswordEditingController = TextEditingController();
    _newPasswordEditingController = TextEditingController();
    _newPasswordConfirmationEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();
    _newPasswordConfirmationEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextCustom(
            title: AppLocalizations.of(context)!.change_password,
            fontfamily: 'pop',
            fontweight: FontWeight.w400,
            size: SizeConfig.scaleTextFont(20),
            color: AppColors.TITLE_ON_BOARDING,
            align: TextAlign.right),
      ),
      body: ListView(
        padding: EdgeInsets.only(
            right: SizeConfig.scaleWidth(16),
            left: SizeConfig.scaleWidth(16),
            top: SizeConfig.scaleHeight(16)),
        children: [
          SizedBox(
            height: SizeConfig.scaleHeight(70),
          ),
          TextCustom(
              title: AppLocalizations.of(context)!.change_screen_message,
              fontfamily: 'pop',
              fontweight: FontWeight.w400,
              size: SizeConfig.scaleTextFont(15),
              color: AppColors.grey,
              align: TextAlign.start),

          SizedBox(height: SizeConfig.scaleHeight(60)),
TextFiled((){},obscureText: true,hint:AppLocalizations.of(context)!.old_password  ,textEditingController: _oldPasswordEditingController,textInputType:TextInputType.text , error:null,),
          SizedBox(height: SizeConfig.scaleHeight(15)),
          TextFiled((){},obscureText: true,hint:AppLocalizations.of(context)!.enter_password ,textEditingController: _newPasswordEditingController,textInputType:TextInputType.text , error: null,),
          SizedBox(height: SizeConfig.scaleHeight(15)),
          TextFiled((){},obscureText: true,hint:AppLocalizations.of(context)!.enter_password_confirmation  ,textEditingController: _newPasswordConfirmationEditingController,textInputType:TextInputType.text , error: null,),

          SizedBox(height: SizeConfig.scaleHeight(40)),
          button(
            text: AppLocalizations.of(context)!.continue_bott,
            color: AppColors.MAIN_COLORE,
            onPressed: () async{
              await performChangePassword();
            },
          ),
        ],
      ),
    );
  }

  Future performChangePassword() async {
    if (checkData()) {
      await changePassword();
    }
  }

  bool checkData() {
    if (check) {
      if (isPasswordConfirmed) {
        return true;
      }
      showSnackBar(context,message: 'Password is not confirmed correctly!',error: false);

    } else {
      showSnackBar(context,message: 'Password Enter required data!',error: true);
    }
    return false;
  }

  bool get check {
    return _newPasswordEditingController.text.isNotEmpty &&
        _newPasswordConfirmationEditingController.text.isNotEmpty &&
        _oldPasswordEditingController.text.isNotEmpty;
  }

  bool get isPasswordConfirmed {
    return _newPasswordConfirmationEditingController.text ==
        _newPasswordEditingController.text;
  }

  Future changePassword() async {
    bool status = await UserGetxController.to.changePassword(context,
        currentPassword: _oldPasswordEditingController.text,
        newPassword: _newPasswordConfirmationEditingController.text);
    if (status) {
      navigateToLoginScreen();
    }
  }

  void navigateToLoginScreen() {
    Navigator.pushReplacementNamed(context, '/login_screen');
  }
}