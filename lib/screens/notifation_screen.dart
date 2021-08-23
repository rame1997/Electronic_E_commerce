import 'package:electronic_e_commerce/getx/notifation_getx_controller.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/notifation_card_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotifationScreen extends StatefulWidget {
  const NotifationScreen({Key? key}) : super(key: key);

  @override
  _NotifationScreenState createState() => _NotifationScreenState();
}

class _NotifationScreenState extends State<NotifationScreen> {
  NotifationGetxController controller = Get.put(NotifationGetxController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await NotifationGetxController.to.getNotifation();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body:
        GetX<NotifationGetxController>(
            builder: (NotifationGetxController controller) {
              return controller.loading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.notifation.isNotEmpty
                  ?Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.scaleWidth(16),
                    right: SizeConfig.scaleWidth(16),
                    top: SizeConfig.scaleHeight(18)),
                child: ListView.separated(
                  itemCount:controller.notifation.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(1.toString()),//demoCarts[index].product.id.toString()
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {

                          // demoCarts.removeAt(index);
                        });
                      },
                      child:NotifiactionCard(notifation: controller.notifation.value[index], onPress: () {
                      }, index: index,),//cart: demoCarts[index]
                    ),
                  ), separatorBuilder: (BuildContext context, int index) {
                  return  Divider(
                    endIndent: SizeConfig.scaleWidth(45),
                    indent: SizeConfig.scaleWidth(45),
                    color: AppColors.grey,
                    thickness: SizeConfig.scaleHeight(1),
                  );
                },
                ),
              ):Center(child: Text('no data'));

            }),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.notifation,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

