
import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:electronic_e_commerce/widgets/text_filed.dart';
import 'package:electronic_e_commerce/widgets/text_filed_passwod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers{
  bool obscureText=true;
  late TextEditingController _mobileTextEditingController;
  late TextEditingController _passwordTextEditingController;
  String? _emailError;
  String? _passError;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobileTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextCustom(
              title: AppLocalizations.of(context)!.login,
              fontfamily: 'pop',
              fontweight: FontWeight.w600,
              size: SizeConfig.scaleTextFont(17),
              color: AppColors.TITLE_APP_BAR,
              align: TextAlign.center),
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
              top: SizeConfig.scaleWidth(16)),
          child: Column(
            children: [
              Align(
                child: Container(
                  child: SvgPicture.asset('images/login.svg'),
                  height: SizeConfig.scaleHeight(67),
                  width: SizeConfig.scaleWidth(67),
                ),
                alignment: Alignment.center,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              TextCustom(
                  title: AppLocalizations.of(context)!.title_login,
                  fontfamily: 'pop',
                  fontweight: FontWeight.w700,
                  size: SizeConfig.scaleTextFont(24),
                  color: AppColors.TITLE_login,
                  align: TextAlign.center),
              SizedBox(
                height: SizeConfig.scaleHeight(10),
              ),
              TextCustom(
                  title: AppLocalizations.of(context)!.sub_title_login,
                  fontfamily: 'pop',
                  fontweight: FontWeight.w400,
                  size: SizeConfig.scaleTextFont(16),
                  color: AppColors.SUB_TITLE_login,
                  align: TextAlign.center),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              TextFiled((){},obscureText: false,hint:AppLocalizations.of(context)!.mobile ,error: _emailError ,textEditingController: _mobileTextEditingController,textInputType:TextInputType.number ,maxLength: 9,),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              TextFiledPassWord((){
                setState(() => obscureText = !obscureText);

              },obscureText: obscureText,hint:AppLocalizations.of(context)!.password ,error: _passError,showSuffix:true ,textEditingController: _passwordTextEditingController,textInputType:TextInputType.text ,),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/forget_password_screen');
                },
                child: Align(
                  child: TextCustom(
                      title: AppLocalizations.of(context)!.forgot_password,
                      fontfamily: 'pop',
                      fontweight: FontWeight.w400,
                      size: SizeConfig.scaleTextFont(16),
                      color: AppColors.TITLE_ON_BOARDING,
                      align: TextAlign.right),
                  alignment: Alignment.centerRight,

                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(24),
              ),
        button(
          text: AppLocalizations.of(context)!.login_small_latter,
          color: AppColors.MAIN_COLORE,
          onPressed: () async{
            await performLogin();
          },
        ),
              SizedBox(
                height: SizeConfig.scaleHeight(24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCustom(
                      title: AppLocalizations.of(context)!.login_create_message,
                      fontfamily: 'pop',
                      fontweight: FontWeight.w400,
                      size: SizeConfig.scaleTextFont(16),
                      color: AppColors.TITLE_ON_BOARDING,
                      align: TextAlign.center),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/create_account_screen');
                    },
                    child: TextCustom(
                        title: AppLocalizations.of(context)!.login_create_sub_message,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w700,
                        size: SizeConfig.scaleTextFont(16),
                        color: AppColors.TITLE_ON_BOARDING,
                        align: TextAlign.center),
                  )

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future performLogin() async{
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_mobileTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty ) {
      return true;
    }
    checkErrors();
    showSnackBar(context,message: 'Please, enter required data',error: true);
    return false;
  }

  Future login()async {
    bool loggedIn = await UserApiController().login(context,
      mobile: _mobileTextEditingController.text,
        password: _passwordTextEditingController.text,);

    if (loggedIn) {
      navigateToHome();
    }else{
      showSnackBar(context,message: 'The login information is incorrect!',error: true);
    }
  }

  void navigateToHome() {
   Navigator.pushReplacementNamed(context, '/bottom_navigation_bar_screen');
  }


  void checkErrors() {
    setState(() {
      _emailError =
      _mobileTextEditingController.text.isEmpty ? 'Enter Mobile Number' : '';
      _passError =
      _passwordTextEditingController.text.isEmpty ? 'Enter password' : '';

    });
  }
}
