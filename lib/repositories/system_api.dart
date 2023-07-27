import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:flutter/material.dart';

class SystemAPI {
  SystemAPI({
    required this.currentUser,
    required this.products,
    required this.rewards,
  });

  UserModel currentUser;
  final List<CoffeeProduct> products;
  List<RewardBase> rewards;

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
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      final data = List<Map<String, dynamic>>.from(snapshot.get('rewards'));
      final rewards = data.map((reward) => RewardBase.fromJson(reward));
      if (rewards.whereType<DiscountVoucher>().isEmpty) return null;
      final bestDiscountOption = rewards.whereType<DiscountVoucher>().reduce(
          (value, element) => value.discount > element.discount
              ? value
              : value.discount == element.discount &&
                      value.validUntil
                              .difference(element.validUntil)
                              .inSeconds <
                          0
                  ? value
                  : element);
      final updatedRewards = rewards
          .where((element) =>
              element.runtimeType != DiscountVoucher ||
              (element as DiscountVoucher) != bestDiscountOption)
          .map((reward) => RewardBase.toJson(reward));
      final updatedUser = UserModel.fromJson(snapshot.data()!).copyWith(
          rewards: rewards
              .where((element) =>
                  element.runtimeType != DiscountVoucher ||
                  (element as DiscountVoucher) != bestDiscountOption)
              .toList());
      transaction.update(docRef, {'rewards': updatedRewards});

      return updatedUser;
    }).then((value) {
      if (value == null) return;
      currentUser = value;
    });
    // if (bestDiscountOption == null) return;
    // currentUser = currentUser.copyWith(
    //     rewards: currentUser.rewards
    //         .where((element) =>
    //             element.runtimeType != DiscountVoucher ||
    //             (element as DiscountVoucher) != bestDiscountOption)
    //         .toList());
    // await firestore.collection('users').doc(currentUser.email).update({
    //   'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
    // });
  }

  Future<void> removeBestFreeshipOption() async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      final data = List<Map<String, dynamic>>.from(snapshot.get('rewards'));
      final rewards = data.map((reward) => RewardBase.fromJson(reward));
      if (rewards.whereType<FreeshipVoucher>().isEmpty) return null;
      final bestFreeshipOption = rewards.whereType<FreeshipVoucher>().reduce(
          (value, element) =>
              value.validUntil.difference(element.validUntil).inSeconds < 0
                  ? value
                  : element);
      final updatedRewards = rewards
          .where((element) =>
              element.runtimeType != FreeshipVoucher ||
              (element as FreeshipVoucher) != bestFreeshipOption)
          .map((reward) => RewardBase.toJson(reward))
          .toList();
      final updatedUser = UserModel.fromJson(snapshot.data()!).copyWith(
          rewards: rewards
              .where((element) =>
                  element.runtimeType != FreeshipVoucher ||
                  (element as FreeshipVoucher) != bestFreeshipOption)
              .toList());
      transaction.update(docRef, {'rewards': updatedRewards});
      return updatedUser;
    }).then((value) {
      if (value == null) return;
      currentUser = value;
    });
    // if (bestFreeshipOption == null) return;
    // currentUser = currentUser.copyWith(
    //     rewards: currentUser.rewards
    //         .where((element) =>
    //             element.runtimeType != FreeshipVoucher ||
    //             (element as FreeshipVoucher) != bestFreeshipOption)
    //         .toList());
    // await firestore.collection('users').doc(currentUser.email).update({
    //   'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
    // });
  }

  Future<void> changeUsername(String newUsername) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      final updatedUser =
          UserModel.fromJson(snapshot.data()!).copyWith(username: newUsername);
      transaction.update(docRef, {
        'username': newUsername,
      });
      return updatedUser;
    }).then((value) => currentUser = value);
    // currentUser = currentUser.copyWith(username: newUsername);
    // await firestore
    //     .collection('users')
    //     .doc(currentUser.email)
    //     .update({'username': newUsername});
  }

  Future<void> changePhoneNumber(String newPhoneNumber) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      final updatedUser =
          UserModel.fromJson(snapshot.data()!).copyWith(phone: newPhoneNumber);
      transaction.update(docRef, {
        'phone': newPhoneNumber,
      });
      return updatedUser;
    }).then((value) => currentUser = value);
    // currentUser = currentUser.copyWith(phone: newPhoneNumber);
    // await firestore
    //     .collection('users')
    //     .doc(currentUser.email)
    //     .update({'phone': newPhoneNumber});
  }

  Future<void> changeEmail(String newEmail) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    final newDocRef =
        FirebaseFirestore.instance.collection('users').doc(newEmail);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      final updatedUser =
          UserModel.fromJson(snapshot.data()!).copyWith(email: newEmail);
      transaction.set(
          newDocRef, currentUser.copyWith(email: newEmail).toJson());
      transaction.delete(docRef);
      return updatedUser;
    }).then((value) => currentUser = value);
    // final oldEmail = currentUser.email;
    // currentUser = currentUser.copyWith(email: newEmail);
    // await firestore.collection('users').doc(oldEmail).delete();

    // await firestore.collection('users').doc(newEmail).set(currentUser.toJson());
  }

  Future<void> changeAddress(String newAddress) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      final updatedUser =
          UserModel.fromJson(snapshot.data()!).copyWith(address: newAddress);
      transaction.update(docRef, {
        'address': newAddress,
      });
      return updatedUser;
    }).then((value) => currentUser = value);
    // currentUser = currentUser.copyWith(address: newAddress);
    // await firestore.collection('users').doc(currentUser.email).update({
    //   'address': newAddress,
    // });
  }

  Future<void> addCartToOnGoing(OrderCartPayed orderCart) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      final updatedInActiveRewards =
          List<Map<String, dynamic>>.from(snapshot.get('inActiveRewards'))
              .map((reward) => RewardBase.fromJson(reward))
              .where((element) =>
                  element is! DrinkReward ||
                  orderCart.items.every(
                      (item) => item.product.name != element.product.name))
              .toList();
      final updatedPoints = snapshot.get('totalPoints') + orderCart.totalPoints;
      final updatedOnGoingOrders = [
        ...List<Map<String, dynamic>>.from(snapshot.get('onGoingOrders'))
            .map((order) => OrderCartPayed.fromJson(order))
            .toList(),
        orderCart,
      ];
      final updatedUser = UserModel.fromJson(snapshot.data()!).copyWith(
        inActiveRewards: updatedInActiveRewards,
        points: updatedPoints,
        onGoingOrders: updatedOnGoingOrders,
      );
      transaction.update(docRef, {
        'inActiveRewards':
            updatedInActiveRewards.map((e) => RewardBase.toJson(e)).toList(),
        'totalPoints': updatedPoints,
        'onGoingOrders': updatedOnGoingOrders.map((e) => e.toJson()).toList(),
      });
      return updatedUser;
    }).then((value) => currentUser = value);
    // currentUser = currentUser.copyWith(
    //   inActiveRewards: currentUser.inActiveRewards
    //       .where((element) =>
    //           element is! DrinkReward ||
    //           orderCart.items
    //               .every((item) => item.product.name != element.product.name))
    //       .toList(),
    //   points: currentUser.totalPoints + orderCart.totalPoints,
    //   onGoingOrders: [...currentUser.onGoingOrders, orderCart],
    // );

    // await firestore.collection('users').doc(currentUser.email).update({
    //   'inActiveRewards':
    //       currentUser.inActiveRewards.map((e) => RewardBase.toJson(e)).toList(),
    //   'totalPoints': currentUser.totalPoints,
    //   'onGoingOrders':
    //       currentUser.onGoingOrders.map((e) => e.toJson()).toList(),
    // });
  }

  Future<void> claimReward(RewardBase reward) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    final rewardRef =
        FirebaseFirestore.instance.collection('rewards').doc(reward.id);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final rewardsSnapshot = await transaction.get(rewardRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      if (!rewardsSnapshot.exists) {
        throw Exception('Reward does not exist!');
      }
      final updatedPoints = snapshot.get('totalPoints') - reward.points;
      final updatedRewards = [
        ...List<Map<String, dynamic>>.from(snapshot.get('rewards'))
            .map((reward) => RewardBase.fromJson(reward))
            .toList(),
        reward
      ];
      final updatedUser = UserModel.fromJson(snapshot.data()!).copyWith(
        points: updatedPoints,
        rewards: updatedRewards,
      );
      final updatedRewardsList = await FirebaseFirestore.instance
          .collection('rewards')
          .get()
          .then((value) =>
              value.docs.map((e) => RewardBase.fromJson(e.data())).toList());
      transaction.update(docRef, {
        'totalPoints': updatedPoints,
        'rewards': updatedRewards.map((e) => RewardBase.toJson(e)).toList(),
      });
      transaction.delete(rewardRef);
      return [
        updatedUser,
        updatedRewardsList,
      ];
    }).then((value) {
      currentUser = value[0] as UserModel;
      rewards = value[1] as List<RewardBase>;
    });
    // currentUser = currentUser.copyWith(
    //   points: currentUser.totalPoints - reward.points,
    //   rewards: [...currentUser.rewards, reward],
    // );
    // rewards = rewards
    //     .where((element) =>
    //         element.runtimeType != reward.runtimeType || element != reward)
    //     .toList();

    // await firestore.collection('users').doc(currentUser.email).update({
    //   'totalPoints': currentUser.totalPoints,
    //   'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
    // });

    // await firestore.collection('rewards').doc(reward.id).delete();
  }

  Future<void> archiveDrinkReward(CoffeeProduct coffeeProduct) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      final currentRewards = List<Map<String, dynamic>>.from(
        snapshot.get('rewards'),
      ).map((reward) => RewardBase.fromJson(reward)).toList();
      if (currentRewards.whereType<DrinkReward>().isEmpty ||
          currentRewards
              .whereType<DrinkReward>()
              .where((element) => element.product.name == coffeeProduct.name)
              .isEmpty) {
        throw Exception('User does not have this reward!');
      }
      final updatedRewards = currentRewards
          .where((element) =>
              element is! DrinkReward ||
              element.product.name != coffeeProduct.name)
          .toList();
      final updatedInActiveRewards = [
        ...List<Map<String, dynamic>>.from(
          snapshot.get('inActiveRewards'),
        ).map((reward) => RewardBase.fromJson(reward)),
        currentRewards.firstWhere((element) =>
            element is DrinkReward &&
            element.product.name == coffeeProduct.name)
      ];
      final updatedUser = UserModel.fromJson(snapshot.data()!).copyWith(
        rewards: updatedRewards,
        inActiveRewards: updatedInActiveRewards,
      );
      transaction.update(docRef, {
        'rewards':
            updatedRewards.map((reward) => RewardBase.toJson(reward)).toList(),
        'inActiveRewards': updatedInActiveRewards
            .map((reward) => RewardBase.toJson(reward))
            .toList(),
      });

      return updatedUser;
    }).then((value) => currentUser = value);
    // currentUser = currentUser.copyWith(
    //   rewards: currentUser.rewards
    //       .where((element) =>
    //           element is! DrinkReward ||
    //           element.product.name != coffeeProduct.name)
    //       .toList(),
    //   inActiveRewards: [
    //     ...currentUser.inActiveRewards,
    //     currentUser.rewards.firstWhere((element) =>
    //         element is DrinkReward &&
    //         element.product.name == coffeeProduct.name)
    //   ],
    // );

    // await firestore.collection('users').doc(currentUser.email).update({
    //   'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
    //   'inActiveRewards':
    //       currentUser.inActiveRewards.map((e) => RewardBase.toJson(e)).toList(),
    // });
  }

  Future<void> popArchiveDrinkReward(CoffeeProduct coffeeProduct) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.email);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('User does not exist!');
      }
      final currentRewards = List<Map<String, dynamic>>.from(
        snapshot.get('rewards'),
      ).map((reward) => RewardBase.fromJson(reward)).toList();
      final currentInActiveRewards = List<Map<String, dynamic>>.from(
        snapshot.get('inActiveRewards'),
      ).map((reward) => RewardBase.fromJson(reward)).toList();
      if (currentInActiveRewards.whereType<DrinkReward>().isEmpty ||
          currentInActiveRewards
              .whereType<DrinkReward>()
              .where((element) => element.product.name == coffeeProduct.name)
              .isEmpty) {
        throw Exception('User does not have this reward!');
      }
      final updatedRewards = [
        ...currentRewards,
        currentInActiveRewards
            .whereType<DrinkReward>()
            .firstWhere((element) => element.product.name == coffeeProduct.name)
      ];
      final updatedInActiveRewards = currentInActiveRewards
          .where((element) =>
              element is! DrinkReward ||
              element.product.name != coffeeProduct.name)
          .toList();
      final updatedUser = UserModel.fromJson(snapshot.data()!).copyWith(
        rewards: updatedRewards,
        inActiveRewards: updatedInActiveRewards,
      );
      transaction.update(docRef, {
        'rewards':
            updatedRewards.map((reward) => RewardBase.toJson(reward)).toList(),
        'inActiveRewards': updatedInActiveRewards
            .map((reward) => RewardBase.toJson(reward))
            .toList(),
      });

      return updatedUser;
    }).then((value) => currentUser = value);
    // currentUser = currentUser.copyWith(
    //   rewards: [
    //     ...currentUser.rewards,
    //     currentUser.inActiveRewards.firstWhere((element) =>
    //         element is DrinkReward &&
    //         element.product.name == coffeeProduct.name)
    //   ],
    //   inActiveRewards: currentUser.inActiveRewards
    //       .where((element) =>
    //           element is! DrinkReward ||
    //           element.product.name != coffeeProduct.name)
    //       .toList(),
    // );

    // await firestore.collection('users').doc(currentUser.email).update({
    //   'rewards': currentUser.rewards.map((e) => RewardBase.toJson(e)).toList(),
    //   'inActiveRewards':
    //       currentUser.inActiveRewards.map((e) => RewardBase.toJson(e)).toList(),
    // });
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
