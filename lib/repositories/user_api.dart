import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:flutter/material.dart';

class UserAPI {
  UserAPI({
    required this.runtimePayload,
    required this.email,
  });

  RuntimePayload runtimePayload;
  String email;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> changeEmail(String newEmail) async {
    final oldEmail = email;
    email = newEmail;
    await firestore.collection('runtime_payloads').doc(oldEmail).delete();
    await firestore
        .collection('runtime_payloads')
        .doc(newEmail)
        .set(runtimePayload.toJson());
  }

  Future<void> customizeOrderDetails(CoffeeProduct coffeeProduct) async {
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart,
        orderDetails: OrderDetails.deflt(product: coffeeProduct));
    await firestore
        .collection('runtime_payloads')
        .doc(email)
        .update(runtimePayload.toJson());
  }

  Future<void> checkOut() async {
    runtimePayload = runtimePayload.copyWith(orderCart: null);
    await firestore
        .collection('runtime_payloads')
        .doc(email)
        .update({'orderCart': null});
  }

  Future<void> levelUp() async {
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart,
        orderDetails: runtimePayload.orderDetails,
        levelUpClicked: true);
    await firestore.collection('runtime_payloads').doc(email).update({
      'levelUpClicked': true,
    });
  }

  Future<void> unClick() async {
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart,
        orderDetails: runtimePayload.orderDetails,
        levelUpClicked: false);
    await firestore.collection('runtime_payloads').doc(email).update({
      'levelUpClicked': false,
    });
  }

  Future<void> addToCart() async {
    if (runtimePayload.orderCart == null) {
      runtimePayload = runtimePayload.copyWith(
          orderDetails: runtimePayload.orderDetails,
          orderCart: OrderCart(items: [runtimePayload.orderDetails!]));
    } else {
      var orderCart = runtimePayload.orderCart!;
      if (orderCart.items
          .where((element) =>
              element.drinkSize == runtimePayload.orderDetails!.drinkSize &&
              element.drinkType == runtimePayload.orderDetails!.drinkType &&
              element.iceLevel == runtimePayload.orderDetails!.iceLevel &&
              element.product == runtimePayload.orderDetails!.product &&
              element.shot == runtimePayload.orderDetails!.shot)
          .isNotEmpty) {
        orderCart = orderCart.copyWith(items: [
          ...orderCart.items.where((element) =>
              element.drinkSize != runtimePayload.orderDetails!.drinkSize ||
              element.drinkType != runtimePayload.orderDetails!.drinkType ||
              element.iceLevel != runtimePayload.orderDetails!.iceLevel ||
              element.product != runtimePayload.orderDetails!.product ||
              element.shot != runtimePayload.orderDetails!.shot),
          runtimePayload.orderDetails!
              .copyWith(amount: runtimePayload.orderDetails!.amount + 1)
        ]);
      } else {
        orderCart = orderCart.copyWith(items: [
          ...runtimePayload.orderCart!.items,
          runtimePayload.orderDetails!
        ]);
      }
      runtimePayload = runtimePayload.copyWith(
          orderDetails: runtimePayload.orderDetails, orderCart: orderCart);
    }
    await firestore
        .collection('runtime_payloads')
        .doc(email)
        .update({'orderCart': runtimePayload.orderCart!.toJson()});
  }

  Future<void> removeFromCart(OrderDetails orderDetails) async {
    assert(runtimePayload.orderCart != null);
    runtimePayload = runtimePayload.copyWith(
        orderDetails: runtimePayload.orderDetails,
        orderCart: runtimePayload.orderCart!.copyWith(
            items: runtimePayload.orderCart!.items
                .where((element) => element != orderDetails)
                .toList()));
    await firestore.collection('runtime_payloads').doc(email).update({
      'orderCart': runtimePayload.orderCart!.toJson(),
    });
  }

  Future<void> recustomizeOrderDetails(OrderDetails orderDetails) async {
    assert(runtimePayload.orderCart != null);
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart!.copyWith(
            items: runtimePayload.orderCart!.items
                .where((element) => element != orderDetails)
                .toList()),
        orderDetails: orderDetails);
    await firestore.collection('runtime_payloads').doc(email).update({
      'orderCart': runtimePayload.orderCart!.toJson(),
      'orderDetails': runtimePayload.orderDetails!.toJson(),
    });
  }

  Future<void> clearOrderDetails() async {
    runtimePayload = runtimePayload.copyWith(
        orderDetails: null, orderCart: runtimePayload.orderCart);

    await firestore.collection('runtime_payloads').doc(email).update({
      'orderDetails': runtimePayload.orderDetails?.toJson(),
    });
  }

  double get price {
    if (runtimePayload.orderCart == null) return 0;
    return runtimePayload.orderCart!.items.fold(
      0,
      (previousValue, element) => previousValue + element.price,
    );
  }

  Future<void> changeAmount(int amount) async {
    assert(runtimePayload.orderDetails != null);
    if (runtimePayload.orderDetails?.product is FreeCoffeeProduct) return;
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart,
        orderDetails: runtimePayload.orderDetails!.copyWith(
            amount: runtimePayload.orderDetails!.amount + amount == 0
                ? runtimePayload.orderDetails!.amount
                : runtimePayload.orderDetails!.amount + amount));
  }

  Future<void> changeShot(DrinkShot shot) async {
    assert(runtimePayload.orderDetails != null);
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart,
        orderDetails: runtimePayload.orderDetails!.copyWith(shot: shot));
    await firestore
        .collection('runtime_payloads')
        .doc(email)
        .update({'orderDetails': runtimePayload.orderDetails!.toJson()});
  }

  Future<void> changeSize(DrinkSize size) async {
    assert(runtimePayload.orderDetails != null);
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart,
        orderDetails: runtimePayload.orderDetails!.copyWith(drinkSize: size));
    await firestore
        .collection('runtime_payloads')
        .doc(email)
        .update({'orderDetails': runtimePayload.orderDetails!.toJson()});
  }

  Future<void> changeSelect(DrinkType type) async {
    assert(runtimePayload.orderDetails != null);
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart,
        orderDetails: runtimePayload.orderDetails!.copyWith(drinkType: type));
    await firestore
        .collection('runtime_payloads')
        .doc(email)
        .update({'orderDetails': runtimePayload.orderDetails!.toJson()});
  }

  Future<void> changeIce(IceLevel ice) async {
    assert(runtimePayload.orderDetails != null);
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart,
        orderDetails: runtimePayload.orderDetails!.copyWith(iceLevel: ice));
    await firestore
        .collection('runtime_payloads')
        .doc(email)
        .update({'orderDetails': runtimePayload.orderDetails!.toJson()});
  }

  Future<void> checkRecustomizeOrderDetails() async {
    runtimePayload = runtimePayload.copyWith(
      orderCart: runtimePayload.orderCart,
      orderDetails: runtimePayload.orderDetails,
      recustomizeOrderDetailsClicked: true,
    );
    await firestore
        .collection('runtime_payloads')
        .doc(email)
        .update({'recustomizeOrderDetailsClicked': true});
  }

  Future<void> unCheckRecustomizeOrderDetails() async {
    runtimePayload = runtimePayload.copyWith(
      orderCart: runtimePayload.orderCart,
      orderDetails: runtimePayload.orderDetails,
      recustomizeOrderDetailsClicked: false,
    );
    await firestore
        .collection('runtime_payloads')
        .doc(email)
        .update({'recustomizeOrderDetailsClicked': false});
  }

  bool get checkRecustomizeOrderDetailsClicked =>
      runtimePayload.recustomizeOrderDetailsClicked;
}
