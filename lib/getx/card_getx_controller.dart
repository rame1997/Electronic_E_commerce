import 'package:electronic_e_commerce/api/card_api_contrller.dart';
import 'package:electronic_e_commerce/models/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CardGetxController extends GetxController {

  final CardApiController cardApiController = CardApiController();
  RxList<CardModel> cards = <CardModel>[].obs;
  RxBool loading = false.obs;
  Rx<CardModel> cardDetiles = CardModel().obs;

  static CardGetxController get to => Get.find();

  void onInit() {
    super.onInit();
    getCards();
    cards.refresh();
  }
  Future<void> getCardDetiles({required int id}) async {
    loading.value = true;
    int index = cards.indexWhere((element) => element.id == id);
    cardDetiles.value= await cards.value[index];
    loading.value = false;
    update();
  }
  Future<void> getCards() async {
    loading.value = true;
    cards.value = await cardApiController.getCard();
    loading.value = false;
    update();
  }

  Future<bool> createCard(BuildContext context, {required CardModel card}) async {
    bool status = await cardApiController.cardRequests(context, holder_name: card.holderName, card_number: card.cardNumber, exp_date:card.expDate, cvv: card.cvv.toString(), type: card.type);
    if (status) {

      return true;
    }
    return false;
  }
  Future<void> deleteCard(BuildContext context, {required int cardId}) async {
    bool status = await cardApiController.deleteCard(context, id: cardId);
    if (status) {
      int index = cards.indexWhere((element) => element.id == cardId);
      cards.removeAt(index);
      update();
    }
  }
  Future<bool> updateCard({required BuildContext context, required CardModel card}) async {
    bool isUpdated = await cardApiController.updateCard(context: context, id: card.id, holder_name: card.holderName, card_number: card.cardNumber, exp_date: card.expDate, cvv: card.cvv, type: card.type);
    if (isUpdated) {
      int index = cards.indexWhere((element) => element.id == card.id);
      cards[index].id = card.id;
      cards[index].holderName = card.holderName;
      cards[index].cardNumber = card.cardNumber;
      cards[index].expDate = card.expDate;
      cards[index].cvv = card.cvv;
      cards[index].type = card.type;
      return true;
    }
    cards.refresh();
    update();
    return false;
  }
}