import 'package:electronic_e_commerce/api/question_api_controller.dart';
import 'package:electronic_e_commerce/models/question.dart';
import 'package:get/get.dart';

class QuestionGetxController extends GetxController{
  RxList<Question> question = <Question>[].obs;
  static QuestionGetxController get to => Get.find();

  @override
  void onInit() {
    getQuestion();
    super.onInit();
  }

  @override
  void onClose() {
    question.clear();
    super.onClose();
  }
  Future<void> getQuestion() async {
    question.value = await QuestionApiController().getQuestion();
    question.refresh();
  }


}