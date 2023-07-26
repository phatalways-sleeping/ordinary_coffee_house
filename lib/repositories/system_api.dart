import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/models/models.dart';

class SystemAPI {
  SystemAPI({
    required this.currentUser,
    required this.products,
    required this.rewards,
  });

  UserModel currentUser;
  final List<CoffeeProduct> products;
  List<RewardBase> rewards;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  UnmodifiableListView<RewardBase> get allRewards =>
      UnmodifiableListView(rewards);

  UnmodifiableListView<DrinkReward> get drinkRewards =>
      UnmodifiableListView(rewards.whereType<DrinkReward>());

  UnmodifiableListView<DrinkReward> get userDrinkRewards =>
      UnmodifiableListView(currentUser.rewards.whereType<DrinkReward>());

  UnmodifiableListView<FreeshipVoucher> get freeshipVouchers =>
      UnmodifiableListView(rewards.whereType<FreeshipVoucher>());

  UnmodifiableListView<DiscountVoucher> get discountVouchers =>
      UnmodifiableListView(rewards.whereType<DiscountVoucher>());

  Future<void> removeBestDiscountOption() async {
    if (bestDiscountOption == null) return;
    currentUser = currentUser.copyWith(
        rewards: currentUser.rewards
            .where((element) =>
                element.runtimeType != DiscountVoucher ||
                (element as DiscountVoucher) != bestDiscountOption)
            .toList());
    await firestore.collection('users').doc(currentUser.email).update({
      'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
    });
  }

  Future<void> removeBestFreeshipOption() async {
    if (bestFreeshipOption == null) return;
    currentUser = currentUser.copyWith(
        rewards: currentUser.rewards
            .where((element) =>
                element.runtimeType != FreeshipVoucher ||
                (element as FreeshipVoucher) != bestFreeshipOption)
            .toList());
    await firestore.collection('users').doc(currentUser.email).update({
      'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
    });
  }

  Future<void> changeUsername(String newUsername) async {
    currentUser = currentUser.copyWith(username: newUsername);
    await firestore
        .collection('users')
        .doc(currentUser.email)
        .update({'username': newUsername});
  }

  Future<void> changePhoneNumber(String newPhoneNumber) async {
    currentUser = currentUser.copyWith(phone: newPhoneNumber);
    await firestore
        .collection('users')
        .doc(currentUser.email)
        .update({'phone': newPhoneNumber});
  }

  Future<void> changeEmail(String newEmail) async {
    final oldEmail = currentUser.email;
    currentUser = currentUser.copyWith(email: newEmail);
    await firestore.collection('users').doc(oldEmail).delete();

    await firestore.collection('users').doc(newEmail).set(currentUser.toJson());
  }

  Future<void> changeAddress(String newAddress) async {
    currentUser = currentUser.copyWith(address: newAddress);
    await firestore.collection('users').doc(currentUser.email).update({
      'address': newAddress,
    });
  }

  Future<void> addCartToOnGoing(OrderCartPayed orderCart) async {
    currentUser = currentUser.copyWith(
      inActiveRewards: currentUser.inActiveRewards
          .where((element) =>
              element is! DrinkReward ||
              orderCart.items
                  .every((item) => item.product.name != element.product.name))
          .toList(),
      points: currentUser.totalPoints + orderCart.totalPoints,
      onGoingOrders: [...currentUser.onGoingOrders, orderCart],
    );

    await firestore.collection('users').doc(currentUser.email).update({
      'inActiveRewards':
          currentUser.inActiveRewards.map((e) => RewardBase.toJson(e)).toList(),
      'totalPoints': currentUser.totalPoints,
      'onGoingOrders':
          currentUser.onGoingOrders.map((e) => e.toJson()).toList(),
    });
  }

  Future<void> claimReward(RewardBase reward) async {
    currentUser = currentUser.copyWith(
      points: currentUser.totalPoints - reward.points,
      rewards: [...currentUser.rewards, reward],
    );
    rewards = rewards
        .where((element) =>
            element.runtimeType != reward.runtimeType || element != reward)
        .toList();

    await firestore.collection('users').doc(currentUser.email).update({
      'totalPoints': currentUser.totalPoints,
      'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
    });

    await firestore.collection('rewards').doc(reward.id).delete();
  }

  Future<void> archiveDrinkReward(CoffeeProduct coffeeProduct) async {
    currentUser = currentUser.copyWith(
      rewards: currentUser.rewards
          .where((element) =>
              element is! DrinkReward ||
              element.product.name != coffeeProduct.name)
          .toList(),
      inActiveRewards: [
        ...currentUser.inActiveRewards,
        currentUser.rewards.firstWhere((element) =>
            element is DrinkReward &&
            element.product.name == coffeeProduct.name)
      ],
    );

    await firestore.collection('users').doc(currentUser.email).update({
      'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
      'inActiveRewards':
          currentUser.inActiveRewards.map((e) => RewardBase.toJson(e)).toList(),
    });
  }

  Future<void> popArchiveDrinkReward(CoffeeProduct coffeeProduct) async {
    currentUser = currentUser.copyWith(
      rewards: [
        ...currentUser.rewards,
        currentUser.inActiveRewards.firstWhere((element) =>
            element is DrinkReward &&
            element.product.name == coffeeProduct.name)
      ],
      inActiveRewards: currentUser.inActiveRewards
          .where((element) =>
              element is! DrinkReward ||
              element.product.name != coffeeProduct.name)
          .toList(),
    );

    await firestore.collection('users').doc(currentUser.email).update({
      'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
      'inActiveRewards':
          currentUser.inActiveRewards.map((e) => RewardBase.toJson(e)).toList(),
    });
  }

  DiscountVoucher? get bestDiscountOption {
    final discountVouchers = currentUser.rewards.whereType<DiscountVoucher>();
    if (discountVouchers.isEmpty) {
      return null;
    }
    return discountVouchers.reduce((value, element) => value.discount >
            element.discount
        ? value
        : value.discount == element.discount &&
                value.validUntil.difference(element.validUntil).inSeconds < 0
            ? value
            : element);
  }

  FreeshipVoucher? get bestFreeshipOption {
    final freeshipVouchers = currentUser.rewards.whereType<FreeshipVoucher>();
    if (freeshipVouchers.isEmpty) {
      return null;
    }
    return freeshipVouchers.reduce((value, element) =>
        value.validUntil.difference(element.validUntil).inSeconds < 0
            ? value
            : element);
  }
}
