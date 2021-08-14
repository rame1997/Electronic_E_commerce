import 'package:electronic_e_commerce/getx/question_getx_controller.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:electronic_e_commerce/utilities/app_colors.dart';
import 'package:electronic_e_commerce/utilities/size_config.dart';
import 'package:electronic_e_commerce/widgets/card_contant.dart';
import 'package:electronic_e_commerce/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class CommonQuestionsScreen extends StatefulWidget {
  const CommonQuestionsScreen({Key? key}) : super(key: key);

  @override
  _CommonQuestionsScreenState createState() => _CommonQuestionsScreenState();
}

class _CommonQuestionsScreenState extends State<CommonQuestionsScreen> {
  QuestionGetxController controller = Get.put(QuestionGetxController());
  @override
  void initState() {
    controller.question;
    super.initState();
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
                  title: TextCustom(
                    title: AppLocalizations.of(context)!.common_questions,
                    fontfamily: 'pop',
                    fontweight: FontWeight.w600,
                    size: SizeConfig.scaleTextFont(17),
                    align: TextAlign.center,
                    color: Colors.black,
                  ),
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
                body: GetX<QuestionGetxController>(
                  builder: (QuestionGetxController controller) {
                    return controller.question.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: controller.question.length,
                            itemBuilder: (context, index) {
                              return CardContant(
                                  SharedPrefController().languageCode == 'en'
                                      ? controller.question[index].questionEn
                                      : controller.question[index].questionAr,
                                  SharedPrefController().languageCode == 'en'
                                      ? controller.question[index].answerEn
                                      : controller.question[index].answerAr,
                                  index);
                            },
                            separatorBuilder: (context, index) {
                              return  Divider(
                                endIndent: SizeConfig.scaleWidth(16),
                                indent: SizeConfig.scaleWidth(16),
                                color: AppColors.grey,
                                thickness: SizeConfig.scaleHeight(1),
                              );
                            },
                          );
                  },
                ))));
  }
}
