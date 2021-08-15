
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:get/get.dart';

class CartGetxController extends GetxController {
  RxList<ProductDetails> cart = <ProductDetails>[].obs;
  RxList<int> quitityCount = <int>[].obs;
  RxDouble total=0.0.obs;
  RxInt quitityProduct=0.obs;
  static CartGetxController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
  add(ProductDetails product,int quitity) {
    if (cart.value.length != 0) {
      bool isFound = false;
      for (int i = 0; i < cart.value.length; i++) {
        if (product.id == cart.value[i].id) {
            isFound = true;
          quitityCount.value[i] += quitity;
            total.value += product.price * quitity;
            update();
            break;
        }
      }
      if (!isFound) {
        cart.add(product);
        quitityCount.add(quitity);
        total.value += product.price * quitity;
        update();
  }
  } else {
      cart.add(product);
      quitityCount.add(quitity);
      total.value += product.price * quitity;
      update();
  }

    update();
  }
  del(int index) {
    total.value-=cart.value[index].price*quitityCount.value[index];
    cart.removeAt(index);
    quitityCount.removeAt(index);
    print(total.value);
    update();
  }
  removeAll() {
    cart.clear();
    quitityCount.clear();
    total.value=0;
    update();
  }

}
