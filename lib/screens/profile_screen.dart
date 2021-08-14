import 'package:electronic_e_commerce/getx/city_getx_controller.dart';
import 'package:electronic_e_commerce/getx/user_getx_controller.dart';
import 'package:electronic_e_commerce/models/city.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/button.dart';
import 'package:electronic_e_commerce/widgets/drop_down_item.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:electronic_e_commerce/widgets/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  bool obscureText = true;
  City? dropDownCity;
  int selectedCity = 0;
  int selectedGender = 0;
 late City dropDownGender;
  CityGetxController city_getx_controller = Get.put(CityGetxController());

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: SharedPrefController().user.name);
    dropDownGender=SharedPrefController().user.gender == 'M'? City.gender[0]: City.gender[1];
   dropDownCity=city_getx_controller.city[SharedPrefController().user.cityId];

  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white),
        title: TextCustom(
          title: AppLocalizations.of(context)!.profile,
          fontfamily: 'pop',
          fontweight: FontWeight.w600,
          size: SizeConfig.scaleTextFont(17),
          align: TextAlign.center,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                height: SizeConfig.scaleHeight(100),
                width: SizeConfig.scaleWidth(105),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.scaleWidth(5),
                      vertical: SizeConfig.scaleHeight(5)),
                  child: SvgPicture.asset('images/on_boarding1.svg'),
                ),
              ),

              SizedBox(height: 80),
              TextFiled((){},obscureText: false,hint:AppLocalizations.of(context)!.name ,textEditingController: nameController,textInputType:TextInputType.text , error:null,),
              SizedBox(height: 20),
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
              SizedBox(height: 42),
              button(
                text: AppLocalizations.of(context)!.save,
                color: AppColors.MAIN_COLORE,
                onPressed: () async{
                  await performUpdateProfile();
                },
              ),

            ],
          ),
        ),
      ),
    );
  }


  Future<void> performUpdateProfile() async {
    bool status = await UserGetxController.to.updateProfile(context,
      city_id: selectedCity,gender: SharedPrefController().languageCode == 'en'? dropDownGender.nameEn: dropDownGender.nameAr,name: nameController.text
        );
    if (status) {
  //    navigateToLoginScreen();
    }
  }




}