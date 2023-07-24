import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/models/order_cart.dart';

class SystemRepository {
  SystemRepository._({
    required this.currentUser,
    required this.products,
    required this.rewards,
  });

  static final SystemRepository _instance = SystemRepository._(
    currentUser: user,
    products: coffeeProducts,
    rewards: [...currentRewards, ...currentVouchers],
  );

  static SystemRepository get mockRepository => _instance;

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

  void removeBestDiscountOption() {
    if (bestDiscountOption == null) return;
    currentUser = currentUser.copyWith(
        rewards: currentUser.rewards
            .where((element) =>
                element.runtimeType != DiscountVoucher ||
                (element as DiscountVoucher) != bestDiscountOption)
            .toList());
  }

  void removeBestFreeshipOption() {
    if (bestFreeshipOption == null) return;
    currentUser = currentUser.copyWith(
        rewards: currentUser.rewards
            .where((element) =>
                element.runtimeType != FreeshipVoucher ||
                (element as FreeshipVoucher) != bestFreeshipOption)
            .toList());
  }

  void changeUsername(String newUsername) {
    currentUser = currentUser.copyWith(username: newUsername);
  }

  void changePhoneNumber(String newPhoneNumber) {
    currentUser = currentUser.copyWith(phone: newPhoneNumber);
  }

  void changeEmail(String newEmail) {
    currentUser = currentUser.copyWith(email: newEmail);
  }

  void changeAddress(String newAddress) {
    currentUser = currentUser.copyWith(address: newAddress);
  }

  void addCartToOnGoing(OrderCartPayed orderCart) {
    for (final order in orderCart.items) {
      if (order.product is FreeCoffeeProduct) {
        _removeDrinkReward(order.product);
      }
    }

    currentUser = currentUser.copyWith(
      points: currentUser.totalPoints + orderCart.totalPoints,
      onGoingOrders: [...currentUser.onGoingOrders, orderCart],
    );
  }

  void claimReward(RewardBase reward) {
    currentUser = currentUser.copyWith(
      points: currentUser.totalPoints - reward.points,
      rewards: [...currentUser.rewards, reward],
    );
    rewards = rewards
        .where((element) =>
            element.runtimeType != reward.runtimeType || element != reward)
        .toList();
  }

  void archiveDrinkReward(CoffeeProduct coffeeProduct) {
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
  }

  void popArchiveDrinkReward(CoffeeProduct coffeeProduct) {
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
  }

  void _removeDrinkReward(CoffeeProduct coffeeProduct) {
    currentUser = currentUser.copyWith(
      inActiveRewards: currentUser.inActiveRewards
          .where((element) =>
              element is! DrinkReward ||
              element.product.name != coffeeProduct.name)
          .toList(),
    );
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
