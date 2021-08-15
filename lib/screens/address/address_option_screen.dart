import 'package:electronic_e_commerce/getx/address_api_controller.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AddressOptionScreen extends StatefulWidget {
  const AddressOptionScreen({Key? key}) : super(key: key);

  @override
  _AddressOptionScreenState createState() => _AddressOptionScreenState();
}

class _AddressOptionScreenState extends State<AddressOptionScreen> {
  AddressGetxController controller = Get.put(AddressGetxController());
  late TextEditingController _nameTextEditingController;
  late TextEditingController _infoTextEditingController;
  late TextEditingController _numberTextEditingController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: buildAppBar(context),
        body:GetX<AddressGetxController> (
        builder: (AddressGetxController controller){
    return controller.loading.value
    ? Center(child: CircularProgressIndicator())
        : controller.addresses.isNotEmpty
    ?
        SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.scaleWidth(16),
              right: SizeConfig.scaleWidth(16),
              top: SizeConfig.scaleHeight(18)),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


            ]),
        )): Center(child: Text('no data'));
        },
        ),
          ),);
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.addresses,
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/add_address_screen');
          },
          child: Icon(Icons.add,color: AppColors.MAIN_COLORE,size: SizeConfig.scaleHeight(20),),
        )
      ],
    );
  }
}
