import 'package:electronic_e_commerce/api/order_api_controller.dart';
import 'package:electronic_e_commerce/models/order.dart';
import 'package:electronic_e_commerce/models/order_detiles.dart';
import 'package:get/get.dart';


class OrderGetxController extends GetxController {
  final OrderApiController orderApiController = OrderApiController();
  RxList<Order> order = <Order>[].obs;
  Rx<OrderDetiles> orderDetiles = OrderDetiles().obs;
  RxBool loading = true.obs;

  static OrderGetxController get to => Get.find();
  @override
  void onInit() {
    getOrder();
    super.onInit();
  }
  Future<void> getOrder() async {
    loading.value = true;
    order.value = await orderApiController.getProduct();
    loading.value = false;
    update();
  }
  Future<void> getOrderDetails({required int id}) async {
    loading.value = true;
    orderDetiles.value= await orderApiController.getProductDetiles(id: id) ;
    loading.value = false;
    update();
  }

}