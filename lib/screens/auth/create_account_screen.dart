import 'package:electronic_e_commerce/api/city_api_controller.dart';
import 'package:electronic_e_commerce/api/user_api_controller.dart';
import 'package:electronic_e_commerce/getx/city_getx_controller.dart';
import 'package:electronic_e_commerce/models/city.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/screens/auth/active_account_screen.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/drop_down_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:electronic_e_commerce/widgets/text_filed.dart';
import 'package:electronic_e_commerce/widgets/text_filed_passwod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:get/get.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with Helpers {
  bool obscureText = true;
  City? dropDownCity;
  City dropDownGender = City.gender[0];
  int selectedCity = 0;
  int selectedGender = 0;
  late TextEditingController _mobileTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _firstNameTextEditingController;
  late TextEditingController _lastNameTextEditingController;
  String? _emailError;
  String? _passError;
  String? _firstError;
  String? _lastError;
  late CityApiController cityApiController = CityApiController();
  List<City> city = <City>[];
  CityGetxController city_getx_controller = Get.put(CityGetxController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _firstNameTextEditingController = TextEditingController();
    _lastNameTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobileTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _lastNameTextEditingController.dispose();
    _firstNameTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextCustom(
              title: AppLocalizations.of(context)!.create_an_account,
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
              top: SizeConfig.scaleHeight(16)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextFiled(() {},
                          obscureText: false,
                          hint: AppLocalizations.of(context)!.first_name,
                          error: _firstError,
                          textEditingController:
                              _firstNameTextEditingController,
                          textInputType: TextInputType.text)),
                  SizedBox(
                    width: SizeConfig.scaleWidth(5),
                  ),
                  Expanded(
                      child: TextFiled(() {},
                          obscureText: false,
                          hint: AppLocalizations.of(context)!.last_name,
                          error: _lastError,
                          textEditingController: _lastNameTextEditingController,
                          textInputType: TextInputType.text)),
                ],
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              TextFiled(
                () {},
                obscureText: false,
                hint: AppLocalizations.of(context)!.mobile,
                error: _emailError,
                textEditingController: _mobileTextEditingController,
                textInputType: TextInputType.number,
                maxLength: 9,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              Row(
                children: [
                  GetX<CityGetxController>(
                      builder: (CityGetxController controller) {
                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.scaleWidth(8),
                          vertical: SizeConfig.scaleWidth(8),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.4), width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        height: SizeConfig.scaleHeight(56),
                        width: double.infinity,
                        child: Center(
                          child: DropdownButton<City>(
                            value: dropDownCity,
                            elevation: 0,
                            underline: Container(color: Colors.transparent),
                            onChanged: (City? city) {
                              setState(() {
                                dropDownCity = city!;
                                selectedCity = city.id;
                              });
                            },
                            hint: Text(
                              AppLocalizations.of(context)!.city,
                            ),
                            items: [
                              for (var itemCity in controller.city)
                                DropdownMenuItem<City>(
                                    value: itemCity,
                                    child: Text(
                                        SharedPrefController().languageCode ==
                                                'en'
                                            ? itemCity.nameEn
                                            : itemCity.nameAr)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    width: SizeConfig.scaleWidth(5),
                  ),
                  DropDowm(
                    list: City.gender,
                    onChanged: (City? gender) {
                      setState(() {
                        dropDownGender = gender!;
                        selectedGender = gender.id;
                      });
                    },
                    dropDownValue: dropDownGender,
                    hint: AppLocalizations.of(context)!.gender,
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              TextFiledPassWord(
                () {
                  setState(() => obscureText = !obscureText);
                },
                obscureText: obscureText,
                hint: AppLocalizations.of(context)!.password,
                error: _passError,
                showSuffix: true,
                textEditingController: _passwordTextEditingController,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextCustom(
                    title: AppLocalizations.of(context)!.create_message,
                    fontfamily: 'pop',
                    fontweight: FontWeight.w400,
                    size: SizeConfig.scaleTextFont(12),
                    color: AppColors.TITLE_APP_BAR,
                    align: TextAlign.start),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(24),
              ),
              button(
                text: AppLocalizations.of(context)!.sign_up,
                color: AppColors.MAIN_COLORE,
                onPressed: () async {
                  await performRegister();
                },
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCustom(
                      title: AppLocalizations.of(context)!.create_login_message,
                      fontfamily: 'pop',
                      fontweight: FontWeight.w400,
                      size: SizeConfig.scaleTextFont(16),
                      color: AppColors.TITLE_ON_BOARDING,
                      align: TextAlign.center),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/login_screen');
                    },
                    child: TextCustom(
                        title: AppLocalizations.of(context)!
                            .create_login_sub_message,
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


  Future performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_mobileTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty &&
        _lastNameTextEditingController.text.isNotEmpty &&
        _firstNameTextEditingController.text.isNotEmpty) {
      return true;
    }
    checkErrors();
    showSnackBar(context, message: 'Please, enter required data', error: true);
    return false;
  }

  Future register() async {
    bool loggedIn = await UserApiController().register(context,
        mobile: _mobileTextEditingController.text,
        password: _passwordTextEditingController.text,
        name: _firstNameTextEditingController.text +
            ' ' +
            _lastNameTextEditingController.text,
        cityId: selectedCity,
        gender: SharedPrefController().languageCode == 'en'
            ? City.gender[selectedGender].nameEn
            : City.gender[selectedGender].nameAr,
        storeApiKey: '87e8b9c5-ec8c-4290-b72c-5ec4c32c0733');

    if (loggedIn) {
      navigateToActive();
    }
  }

  void navigateToActive() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ActiveScreen(
                  phoneNumber: _mobileTextEditingController.text,
                  code: SharedPrefController().code,
                  create: true,
                )));
    print('rami');
  }

  void checkErrors() {
    setState(() {
      _emailError = _mobileTextEditingController.text.isEmpty
          ? 'Enter Mobile Number'
          : '';
      _passError =
          _passwordTextEditingController.text.isEmpty ? 'Enter password' : '';
      _firstError = _firstNameTextEditingController.text.isEmpty
          ? 'Enter first Name'
          : '';
      _lastError =
          _lastNameTextEditingController.text.isEmpty ? 'Enter last Name' : '';
    });
  }
}
