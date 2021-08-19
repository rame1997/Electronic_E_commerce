
import 'package:electronic_e_commerce/Database/controllers/cart_db_controller.dart';
import 'package:electronic_e_commerce/models/cart.dart';
import 'package:electronic_e_commerce/models/product.dart';
import 'package:electronic_e_commerce/models/product_detiles.dart';
import 'package:electronic_e_commerce/preferences/user_preferences.dart';
import 'package:get/get.dart';

class CartGetxController extends GetxController {
  CartDbController _dbController = CartDbController();

  RxList<Cart> cart = <Cart>[].obs;
  RxList<ProductDetails> cartDetailes = <ProductDetails>[].obs;
  RxList<int> quitityCount = <int>[].obs;
  RxDouble total=0.0.obs;
  RxInt quitityProduct=0.obs;
  static CartGetxController get to => Get.find();

  @override
  void onInit() {
    readCart();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }



  // add(ProductDetails product,int quitity) {
  //   if (cartDetailes.value.length != 0) {
  //     bool isFound = false;
  //     for (int i = 0; i < cartDetailes.value.length; i++) {
  //       if (product.id == cartDetailes.value[i].id) {
  //           isFound = true;
  //         quitityCount.value[i] += quitity;
  //           total.value += product.price * quitity;
  //           update();
  //           break;
  //       }
  //     }
  //     if (!isFound) {
  //       cartDetailes.add(product);
  //       quitityCount.add(quitity);
  //       total.value += product.price * quitity;
  //       update();
  // }
  // } else {
  //     cartDetailes.add(product);
  //     quitityCount.add(quitity);
  //     total.value += product.price * quitity;
  //     update();
  // }
  //
  //   update();
  // }
  // del(int index) {
  //   total.value-=cartDetailes.value[index].price*quitityCount.value[index];
  //   cartDetailes.removeAt(index);
  //   quitityCount.removeAt(index);
  //   print(total.value);
  //   update();
  // }
  // removeAll() {
  //   cartDetailes.clear();
  //   quitityCount.clear();
  //   total.value=0;
  //   update();
  // }



//*************************************
  Future<bool> add(ProductDetails product,int quitity) async{
    Cart newCart=Cart();
    newCart.quantity=quitity;
    newCart.product_id=product.id;
    newCart.nameEn=product.nameEn;
    newCart.nameAr=product.nameAr;
    newCart.price=product.price.toDouble();
    newCart.user_id=SharedPrefController().getUser().id;

    if (cart.value.length != 0) {
      bool isFound = false;
      for (int i = 0; i < cart.value.length; i++) {
        if (product.id == cart.value[i].product_id) {
            isFound = true;
            bool updated = await _dbController.update(newCart);
            if (updated) {
              int index =
              cart.indexWhere((element) => element.product_id == newCart.product_id);
              if (index != -1) {
                cart[index] = newCart;
                print(cart[index].quantity);
                total.value += product.price * quitity;
                update();
                return true;
              }
            }
            update();
            break;
        }
      }
      if (!isFound) {
        int id = await _dbController.create(newCart);
        if (id != 0) {
          newCart.id = id;
          cart.add(newCart);
          cartDetailes.add(product);
          total.value += product.price * quitity;
          update();
          return true;
        }
        update();
  }
  } else {
      int id = await _dbController.create(newCart);
      if (id != 0) {
        newCart.id = id;
        cart.add(newCart);
        cartDetailes.add(product);
        total.value += product.price * quitity;
        update();
        return true;
      }
  }
    update();
    return false;
  }
  del(int productId) async{
    bool deletedRows=await _dbController.delete(productId);
    int index = cart.indexWhere((element) => element.product_id == productId);
    int indexCartDetailes = cartDetailes.indexWhere((element) => element.id == productId);

    if(deletedRows){
      total.value-=(cart.value[index].price*cart.value[index].quantity);
      cart.removeAt(index);
      cartDetailes.removeAt(indexCartDetailes);

    }
    print(total.value);
    update();
  }
   removeAll() async{
    await _dbController.deleteAllRows();
    cart.clear();
    cartDetailes.clear();
    total.value=0;
    update();
  }
  Future<void> readCart() async {
    cart.value = await _dbController.read() ;
    update();
  }

}
