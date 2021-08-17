import 'package:electronic_e_commerce/api/contant_api_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/card_contant.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:electronic_e_commerce/widgets/text_filed.dart';
import 'package:electronic_e_commerce/widgets/text_filed_contant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ContantScreen extends StatefulWidget  {
  @override
  _ContantScreenState createState() => _ContantScreenState();
}

class _ContantScreenState extends State<ContantScreen>with Helpers {
  late TextEditingController _subjectTextEditingController;
  late TextEditingController _detilesTextEditingController;
  late TextEditingController _nameTextEditingController;
  late TextEditingController _emailTextEditingController;

  String? _subjectError;
  String? _detilesError;
  String? _emailError;
  String? _nameError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subjectTextEditingController = TextEditingController();
    _detilesTextEditingController = TextEditingController();
    _nameTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subjectTextEditingController.dispose();
    _detilesTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    super.dispose();
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
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_outlined,
                        color: AppColors.MAIN_COLORE),
                  ),
                  title: TextCustom(
                      title: AppLocalizations.of(context)!.contant_us,
                      fontfamily: 'pop',
                      fontweight: FontWeight.w700,
                      size: SizeConfig.scaleTextFont(20),
                      color: Colors.black,
                      align: TextAlign.center),
                ),
                body: Scrollbar(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: SizeConfig.scaleHeight(130),
                              color: AppColors.MAIN_COLORE,
                              child: Center(
                                child:  TextCustom(
                                    title: AppLocalizations.of(context)!.contant_us,
                                    fontfamily: 'pop',
                                    fontweight: FontWeight.w400,
                                    size: SizeConfig.scaleTextFont(32),
                                    color: Colors.white,
                                    align: TextAlign.center)
                              ),
                            ),
                            CardContant(AppLocalizations.of(context)!.email,
                                'rameatalah@gmail.com', 1),
                            CardContant(AppLocalizations.of(context)!.addresses,
                                'AL Wehda Street AL Jamal Building 7th floor', 2),
                            CardContant(AppLocalizations.of(context)!.mobile,
                                '+970-059-2209691', 3),
                            Center(
                              child: Container(
                                width: SizeConfig.scaleWidth(50),
                                height: SizeConfig.scaleHeight(50),
                                child: Icon(Icons.headset,
                                    size: 30,
                                    color: AppColors.MAIN_COLORE),
                              ),
                            ),
                            Center(
                              child: TextCustom(
                                title: AppLocalizations.of(context)!.contant_us_message,
                        fontfamily: 'pop',
                        fontweight: FontWeight.w500,
                        size: SizeConfig.scaleTextFont(24),
                        color: AppColors.MAIN_COLORE,
                        align: TextAlign.center)
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(10),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.scaleWidth(8),
                                  right: SizeConfig.scaleWidth(8)),
                              child: Row(
                                children: [
                                  Flexible(
                                      child: TextFiledContant(
                              AppLocalizations.of(context)!.name,
                                          _nameTextEditingController,
                                          _nameError,
                                          1,
                                          1,
                                          TextInputType.text)),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(5),
                                  ),
                                  Flexible(
                                      child: TextFiledContant(
                                          AppLocalizations.of(context)!.email,
                                          _emailTextEditingController,
                                          _emailError,
                                          1,
                                          1,
                                          TextInputType.emailAddress)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(10),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.scaleWidth(8),
                                  right: SizeConfig.scaleWidth(8)),
                              child: SingleChildScrollView(
                                  child: Flexible(
                                      child: TextFiledContant(
                                          AppLocalizations.of(context)!.subject,
                                          _subjectTextEditingController,
                                          _subjectError,
                                          1,
                                          1,
                                          TextInputType.text))),
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(10),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.scaleWidth(8),
                                  right: SizeConfig.scaleWidth(8)),
                              child: SingleChildScrollView(
                                  child: Flexible(
                                      child: TextFiledContant(
                                          AppLocalizations.of(context)!.message,
                                          _detilesTextEditingController,
                                          _detilesError,
                                          1,
                                          10,
                                          TextInputType.text))),
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(25),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(right: SizeConfig.scaleWidth(8),left:SizeConfig.scaleWidth(8) ),
                              child: button(
                                text: AppLocalizations.of(context)!.send,
                                color: AppColors.MAIN_COLORE,
                                onPressed: () async{
                                  await performContant();
                                },
                              ),
                            ),
                          ],
                        ))))));
  }

  Future performContant()async {
    if (checkData()) {
     await send();
    }
  }

  bool checkData() {
    if (_nameTextEditingController.text.isNotEmpty &&
        _subjectTextEditingController.text.isNotEmpty &&
        _detilesTextEditingController.text.isNotEmpty &&
        _emailTextEditingController.text.isNotEmpty) {
      return true;
    }
    checkErrors();
    showSnackBar(
        context,
        message: 'Please, enter required data',
        error: true);

    return false;
  }

  Future<void> send() async{
    bool status = await ContantApiController().
    contactRequests(context,message: _detilesTextEditingController.text, subject:_subjectTextEditingController.text);

    if (status) {
      _subjectTextEditingController.clear();
      _nameTextEditingController.clear();
      _emailTextEditingController.clear();
      _detilesTextEditingController.clear();
          }

  }


  void checkErrors() {
    setState(() {
      _nameError = _nameTextEditingController.text.isEmpty ? 'Enter name ' : '';
      _emailError =
      _emailTextEditingController.text.isEmpty ? 'Enter email address' : '';
       _subjectError =
      _subjectTextEditingController.text.isEmpty ? 'Enter sublject ' : '';
      _detilesError =
      _detilesTextEditingController.text.isEmpty ? 'Enter detelies ' : '';
    });
  }
}
