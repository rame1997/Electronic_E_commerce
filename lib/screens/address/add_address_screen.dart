import 'package:electronic_e_commerce/api/city_api_controller.dart';
import 'package:electronic_e_commerce/getx/address_getx_controller.dart';
import 'package:electronic_e_commerce/getx/city_getx_controller.dart';
import 'package:electronic_e_commerce/mixins/helpers.dart';
import 'package:electronic_e_commerce/models/address.dart';
import 'package:electronic_e_commerce/models/city.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:electronic_e_commerce/widgets/text_filed.dart';
import 'package:electronic_e_commerce/widgets/text_filed_contant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> with Helpers{
  late TextEditingController _nameTextEditingController;
  late TextEditingController _infoTextEditingController;
  late TextEditingController _numberTextEditingController;
  City? dropDownCity;
  int selectedCity = 0;
  String? _nameError;
  String? _infoError;
  String? _numberError;
  late CityApiController cityApiController = CityApiController();
  List<City> city = <City>[];
  CityGetxController city_getx_controller = Get.put(CityGetxController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextEditingController = TextEditingController();
    _infoTextEditingController = TextEditingController();
    _numberTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameTextEditingController.dispose();
    _infoTextEditingController.dispose();
    _numberTextEditingController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TextCustom(
              title: AppLocalizations.of(context)!.add_address,
              fontfamily: 'pop',
              fontweight: FontWeight.w600,
              size: SizeConfig.scaleTextFont(17),
              color: AppColors.TITLE_APP_BAR,
              align: TextAlign.center),
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
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
              TextFiled(() {},
                  obscureText: false,
                  hint: AppLocalizations.of(context)!.name,
                  error: _nameError,
                  textEditingController:
                  _nameTextEditingController,
                  textInputType: TextInputType.text),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              TextFiled(
                    () {},
                obscureText: false,
                hint: AppLocalizations.of(context)!.mobile,
                error: _numberError,
                textEditingController: _numberTextEditingController,
                textInputType: TextInputType.number,
                maxLength: 9,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              TextFiledContant(
                  AppLocalizations.of(context)!.info,
                  _infoTextEditingController,
                  _infoError,
                  1,
                  10,
                  TextInputType.text),
              SizedBox(
                height: SizeConfig.scaleHeight(16),
              ),
              GetX<CityGetxController>(
                  builder: (CityGetxController controller) {
                    return Container(
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
                      child: Expanded(
                        child: DropdownButton<City>(
                          value: dropDownCity,
                          elevation: 0,
                          isExpanded: true,
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
                    );
                  }),
              SizedBox(
                height: SizeConfig.scaleHeight(24),
              ),
              button(
                text: AppLocalizations.of(context)!.add,
                color: AppColors.MAIN_COLORE,
                onPressed: () async {
                  await performAdd();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> performAdd() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (
    _nameTextEditingController.text.isNotEmpty &&
        _infoTextEditingController.text.isNotEmpty &&
        _numberTextEditingController.text.isNotEmpty&& dropDownCity!=null) {
      return true;
    }
    checkErrors();
    return false;
  }

  Future<void> save() async {
    Address address = Address();
    address.name = _nameTextEditingController.text;
    address.contactNumber = _numberTextEditingController.text;
    address.info = _infoTextEditingController.text;
    address.cityId = selectedCity;

    bool status = await AddressGetxController.to.createAddress(
        context: context,
        address: address
    );
    if (status) {
      Navigator.pop(context);
    } else {
      showSnackBar(context, message: 'Please, check data', error: true);
    }
  }
  void checkErrors() {
    setState(() {
      _numberError = _numberTextEditingController.text.isEmpty
          ? 'Enter Mobile Number'
          : '';
      _infoError =
      _infoTextEditingController.text.isEmpty ? 'Enter Info' : '';
      _nameError = _nameTextEditingController.text.isEmpty
          ? 'Enter Name'
          : '';

    });
  }
}

