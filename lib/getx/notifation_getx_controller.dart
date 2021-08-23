
import 'package:electronic_e_commerce/api/notifation_api_controller.dart';
import 'package:electronic_e_commerce/models/notafiction.dart';
import 'package:get/get.dart';

class NotifationGetxController extends GetxController{
  RxList<Notifation> notifation = <Notifation>[].obs;
  static NotifationGetxController get to => Get.find();
  RxBool loading = true.obs;

  @override
  void onInit() {
    getNotifation();
    super.onInit();
  }

  @override
  void onClose() {
    notifation.clear();
    super.onClose();
  }
  Future<void> getNotifation() async {
    loading.value = true;
    notifation.value = await NotifationApiController().getNotifation();
    loading.value = false;
    notifation.refresh();
  }


}