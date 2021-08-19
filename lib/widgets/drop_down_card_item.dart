import 'package:electronic_e_commerce/models/card.dart';
import 'package:electronic_e_commerce/models/city.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';

class DropDowmCard extends StatelessWidget {
  CardModel? dropDownValue;
  String hint;
  Function(CardModel?)onChanged;
  List<CardModel> list;

  DropDowmCard({required this.dropDownValue, required this.onChanged, required this.list,required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: DropdownButton<CardModel>(
          value: dropDownValue,
          isExpanded: true,
          elevation: 0,
          underline: Container(color: Colors.transparent),
          onChanged: onChanged,
          hint: Text(hint),
          items: list
              .map<DropdownMenuItem<CardModel>>((CardModel card) {
            return DropdownMenuItem<CardModel>(
              value: card,
              child: Text(SharedPrefController().languageCode=='en'?card.cardNumber:card.cardNumber),
            );
          }).toList(),
        ),
      ),
    );
  }
}


