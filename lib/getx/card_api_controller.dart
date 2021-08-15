import 'package:electronic_e_commerce/api/card_api_contrller.dart';
import 'package:electronic_e_commerce/models/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CardGetxController extends GetxController {

  final CardApiController cardApiController = CardApiController();
  RxList<CardModel> cards = <CardModel>[].obs;
  RxBool loading = false.obs;

  static CardGetxController get to => Get.find();

  void onInit() {
    super.onInit();
    getCards();
    cards.refresh();
  }
  Future<void> getCards() async {
    loading.value = true;
    cards.value = await cardApiController.getCard();
    loading.value = false;
    update();
  }

  Future<bool> createCard(BuildContext context, {required CardModel card}) async {
    bool status = await cardApiController.cardRequests(context, holder_name: card.holderName, card_number: card.cardNumber, exp_date:card.expDate, cvv: card.cvv, type: card.type);
    if (status) {

      return true;
    }
    return false;
  }
  Future<void> deleteCard(BuildContext context, {required int cardId}) async {
    loading.value = true;
    bool status = await cardApiController.deleteCard(context, id: cardId);
    if (status) {
      int index = cards.indexWhere((element) => element.id == cardId);
      cards.removeAt(index);
    }
    cards.refresh();
    update();
    loading.value = false;
  }
}