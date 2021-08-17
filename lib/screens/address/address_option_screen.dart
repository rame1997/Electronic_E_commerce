import 'package:electronic_e_commerce/getx/address_getx_controller.dart';
import 'package:electronic_e_commerce/screens/address/update_address_screen.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/address_option_item.dart';
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
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await AddressGetxController.to.getAddress();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int tot=0;
    return SafeArea(
        child: Scaffold(
          appBar: buildAppBar(context),
        body:GetX<AddressGetxController> (
        builder: (AddressGetxController controller){
    return controller.loading.value
    ? Center(child: CircularProgressIndicator())
        : controller.addresses.isNotEmpty
    ?
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.scaleWidth(16),
              right: SizeConfig.scaleWidth(16),
              top: SizeConfig.scaleHeight(18),bottom: SizeConfig.scaleHeight(24)
          ),
          child: ListView.builder(
            itemCount: controller.addresses.value.length,
           itemBuilder: (BuildContext context,int index){
               tot=index+1;
             return AddressOptionItem(title: AppLocalizations.of(context)!.card_address+tot.toString(), subTitle: AppLocalizations.of(context)!. address_number_message, icon: Icons.place, index: index, onTapEdit: () {
  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAddressScreen(address: controller.addresses[index],)),);
}, onTapDelete: () {
  controller.deleteAddress(context, addressId:  controller.addresses.value[index].id);
},);

           },
            ),
      )
              :
    Center(child: Text('no data'));
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
        IconButton(onPressed: (){
          Navigator.pushNamed(context, '/add_address_screen');

        },icon:Icon(Icons.add,color: AppColors.MAIN_COLORE,size: SizeConfig.scaleHeight(30)) ,)
      ],
    );
  }
}
