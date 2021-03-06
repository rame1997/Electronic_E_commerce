import 'package:electronic_e_commerce/api/address_api_controller.dart';
import 'package:electronic_e_commerce/models/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddressGetxController extends GetxController {
  final AddressApiController addressApiController = AddressApiController();
  RxList<Address>  addresses = <Address>[].obs;
  RxBool loading = true.obs;
  Rx<Address> addressDetiles = Address().obs;

  static AddressGetxController get to => Get.find();
  @override
  void onInit() {
    getAddress();
    addresses.refresh();
    super.onInit();
  }

  Future<void> getAddressDetiles({required int id}) async {
    loading.value = true;
    int index = addresses.indexWhere((element) => element.id == id);
    addressDetiles.value= await addresses.value[index];
    update();
    loading.value = false;
  }
  Future<void> getAddress() async {
    loading.value = true;
    addresses.value = await addressApiController.getAddress();
    loading.value = false;
    update();
  }
  Future<void> deleteAddress(BuildContext context, {required int addressId}) async {
    bool status = await addressApiController.deleteAddress(context, id: addressId);
    print(status);
    if (status) {
      int index = addresses.indexWhere((element) => element.id == addressId);
      addresses.removeAt(index);
      update();

    }

  }
  Future<bool> createAddress({required BuildContext context, required Address address}) async {
    bool newAddress = await addressApiController.addressRequests(context, name: address.name, info: address.info, contact_number: address.contactNumber, city_id: address.cityId);
    if (newAddress) {
      addresses.add(address);
      update();
      return true;
    }
    return false;
  }
  Future<bool> updateAddress({required BuildContext context, required Address address}) async {
    bool isUpdated = await addressApiController.updateAddress(address: address, context: context);
    if (isUpdated) {
      int index = addresses.indexWhere((element) => element.id == address.id);
      addresses[index].name = address.name;
      addresses[index].info = address.info;
      addresses[index].contactNumber = address.contactNumber;
      addresses[index].lang = address.lang;
      addresses[index].lat = address.lat;
      addresses[index].cityId = address.cityId;
      return true;
    }
    addresses.refresh();
    update();
    return false;
  }
}