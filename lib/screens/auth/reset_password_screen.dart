import 'dart:async';

import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:electronic_e_commerce/widgets/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String phoneNumber;
  final String code;



  ResetPasswordScreen({required this.phoneNumber,required this.code});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with Helpers{

  late TextEditingController _newPasswordTextEditingController;
  late TextEditingController _newPasswordConfirmationTextEditingController;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  String? _newPassword;
  String? _newPasswordConfirmation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newPasswordTextEditingController = TextEditingController();
    _newPasswordConfirmationTextEditingController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();


  }
  @override
  void dispose() {
    // TODO: implement dispose
    _newPasswordTextEditingController.dispose();
    _newPasswordConfirmationTextEditingController.dispose();
    errorController!.close();
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: TextCustom(
                  title: AppLocalizations.of(context)!.reset_password,
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
                        title: AppLocalizations.of(context)!.reset_message,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w700,
                        size: SizeConfig.scaleTextFont(25),
                        color: AppColors.TITLE_APP_BAR,
                        align: TextAlign.start),
                    SizedBox(height: SizeConfig.scaleHeight(16)),

                    TextCustom(
                        title: AppLocalizations.of(context)!.enter_password,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w500,
                        size: SizeConfig.scaleTextFont(16),
                        color: AppColors.SUB_TITLE_ON_BOARDING,
                        align: TextAlign.start),

                    SizedBox(height: SizeConfig.scaleHeight(16)),

                    TextFiled((){},obscureText: true,hint:AppLocalizations.of(context)!.password  ,textEditingController: _newPasswordTextEditingController,textInputType:TextInputType.text , error: _newPassword,),
                    SizedBox(height: SizeConfig.scaleHeight(16)),

                    TextCustom(
                        title: AppLocalizations.of(context)!.password_confirmation,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w500,
                        size: SizeConfig.scaleTextFont(16),
                        color: AppColors.SUB_TITLE_ON_BOARDING,
                        align: TextAlign.start),

                    SizedBox(height: SizeConfig.scaleHeight(16)),

                    TextFiled((){},obscureText: true,hint:AppLocalizations.of(context)!.password_confirmation  ,textEditingController: _newPasswordConfirmationTextEditingController,textInputType:TextInputType.text , error: _newPasswordConfirmation,),

                    SizedBox(
                      height: SizeConfig.scaleHeight(24),
                    ),
                    button(
                      text: AppLocalizations.of(context)!.confirmation,
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

        await reset();

    }
  }
  bool checkData() {

    if (_newPasswordTextEditingController.text.isNotEmpty&&
        _newPasswordConfirmationTextEditingController.text.isNotEmpty) {
      if (isPasswordConfirmed) {

      }else{
        showSnackBar(context,message: 'Password is not confirmed correctly!',error: true);
      }
      return true;
    }
    checkErrors();
    showSnackBar(context,message: 'Please, enter required data',error: true);
    return false;
  }

  Future reset()async {
    bool reset = await UserApiController().resetPassword(context, password:_newPasswordTextEditingController.text, code: widget.code, password_confirmation: _newPasswordConfirmationTextEditingController.text, mobile: widget.phoneNumber);


    if (reset) {
      navigateToLogin();
    }
  }

  void navigateToLogin() {

    Navigator.pushReplacementNamed(context, '/login_screen');
  }


  void checkErrors() {
    setState(() {
      _newPassword =
      _newPasswordTextEditingController.text.isEmpty ? 'Enter password' : '';
      _newPasswordConfirmation =
      _newPasswordConfirmationTextEditingController.text.isEmpty ? 'Enter Confirm password' : '';

    });
  }
  bool get isPasswordConfirmed {
    return _newPasswordConfirmationTextEditingController.text ==
        _newPasswordTextEditingController.text;
  }
}
