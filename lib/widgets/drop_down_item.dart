import 'package:electronic_e_commerce/models/city.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';

class DropDowm extends StatelessWidget {
  City dropDownValue;
String hint;
Function(City?)onChanged;
List<City> list;

DropDowm({required this.dropDownValue, required this.onChanged, required this.list,required this.hint});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding:  EdgeInsets.symmetric(
          horizontal: SizeConfig.scaleWidth(8),
          vertical: SizeConfig.scaleWidth(8),),
        decoration: BoxDecoration(
            border: Border.all(color:Colors.black.withOpacity(0.4),width: 1),
            borderRadius: BorderRadius.circular(10)
        ),
        height: SizeConfig.scaleHeight(56),
        width: double.infinity,
        child: Center(
          child: DropdownButton<City>(
            value: dropDownValue,
            isExpanded: true,
            elevation: 0,
            underline: Container(color: Colors.transparent),
            onChanged: onChanged,
            hint: Text(hint),
            items: list
                .map<DropdownMenuItem<City>>((City city) {
              return DropdownMenuItem<City>(
                value: city,
                child: Text(SharedPrefController().languageCode=='en'?city.nameEn:city.nameAr),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


