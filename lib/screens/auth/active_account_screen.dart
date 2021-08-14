import 'dart:async';

import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/screens/auth/reset_password_screen.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'login_screen.dart';

class ActiveScreen extends StatefulWidget {
  final String phoneNumber;
  final int code;
  final bool create;


  ActiveScreen({required this.phoneNumber,required this.code,required this.create});

  @override
  _ActiveScreenState createState() =>
      _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> with Helpers{
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextCustom(
            title: AppLocalizations.of(context)!.verification_code,
            fontfamily: 'pop',
            fontweight: FontWeight.w600,
            size: SizeConfig.scaleTextFont(17),
            color: AppColors.TITLE_ON_BOARDING,
            align: TextAlign.center),
      ),
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: SizeConfig.scaleHeight(30)),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SvgPicture.asset('images/verification.svg'),
                ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(16)),
              Padding(
                padding:
                 EdgeInsets.symmetric(horizontal:SizeConfig.scaleWidth(30) , vertical: SizeConfig.scaleHeight(4)),
                child: RichText(
                  text: TextSpan(
                      text: AppLocalizations.of(context)!.verification_code_sub_title ,
                      children: [
                        TextSpan(
                            text: "${widget.phoneNumber}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding:  EdgeInsets.symmetric(
                        vertical: SizeConfig.scaleHeight(4), horizontal: SizeConfig.scaleWidth(95)),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 4) {
                          return  AppLocalizations.of(context)!.fill;
                        } else {
                          
                          return '';
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: SizeConfig.scaleHeight(45),
                        fieldWidth: SizeConfig.scaleWidth(40),
                        activeFillColor: AppColors.MAIN_COLORE,
                        inactiveFillColor:Colors.white,
                        selectedFillColor: Colors.white,
                        selectedColor: AppColors.MAIN_COLORE,
                  activeColor: AppColors.MAIN_COLORE,
                        inactiveColor: AppColors.TITLE_ON_BOARDING

                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                        setState(() {
                          currentText=v;
                        });

                      },
                      onChanged: (value) {
                      },
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleHeight(10)),
                child: Text(
                  hasError ?AppLocalizations.of(context)!.active_message: "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height:SizeConfig.scaleHeight(5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCustom(
                      title: AppLocalizations.of(context)!.active_sub_message,
                      fontfamily: 'pop',
                      fontweight: FontWeight.w400,
                      size: SizeConfig.scaleTextFont(15),
                      color: AppColors.TITLE_ON_BOARDING,
                      align: TextAlign.center),
                  InkWell(
                    onTap: (){
                      showSnackBar(context,message: AppLocalizations.of(context)!.resend,error: false);

                    },
                    child: TextCustom(
                        title: AppLocalizations.of(context)!.resend,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w700,
                        size: SizeConfig.scaleTextFont(15),
                        color: AppColors.TITLE_ON_BOARDING,
                        align: TextAlign.center),
                  )

                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: SizeConfig.scaleHeight(52),
                  child: TextButton(
                    onPressed: () async{
                      formKey.currentState!.validate();
                      if (currentText.length == 4 && currentText == widget.code.toString()) {
                        if(widget.create){
                        bool active = await UserApiController().active(context,code: currentText, mobile: widget.phoneNumber,
                         );

                        setState(
                                () {
                              hasError = false;
                            },
                        );
                        if (active) {
                          navigateToLogin();
                        }else {
                          errorController!.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() => hasError = true);

                        }
                      }
                      else{
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ResetPasswordScreen(phoneNumber:widget.phoneNumber, code: currentText,)));
                      }}
                    },
                    child: Center(
                        child: TextCustom(
                        title: AppLocalizations.of(context)!.verify,
                      fontfamily: 'pop',
                      fontweight: FontWeight.w700,
                      size: SizeConfig.scaleTextFont(20),
                      color:Colors.white,
                      align: TextAlign.center),),
                  ),
                ),
                decoration: BoxDecoration(
                    color: AppColors.MAIN_COLORE,
                    borderRadius: BorderRadius.circular(27),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void navigateToLogin() {
    Navigator.push(context,widget.create?MaterialPageRoute(builder: (BuildContext context)=>LoginScreen()):
    MaterialPageRoute(builder: (BuildContext context)=>ResetPasswordScreen(phoneNumber:widget.phoneNumber, code: currentText,)));
  }
}
