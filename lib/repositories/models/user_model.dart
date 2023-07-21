import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'loyalty_membership.dart';

import 'models.dart';
import 'order_cart.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.historyOrders,
    required this.onGoingOrders,
    required this.totalPoints,
    this.rewards = const [],
    this.inActiveRewards = const [],
    this.tier = const BronzeMembership(),
  });

  final String username;
  final String email;
  final String address;
  final String phone;
  final int totalPoints;

  final List<OrderCartPayed> historyOrders;
  final List<OrderCartPayed> onGoingOrders;

  final List<RewardBase> rewards;
  final List<RewardBase> inActiveRewards;

  final LoyaltyMembership tier;

  int get totalDrinks {
    int totalDrinks = 0;
    for (final orderCart in historyOrders) {
      for (final order in orderCart.items) {
        totalDrinks += order.amount;
      }
    }
    for (final orderCart in onGoingOrders) {
      for (final order in orderCart.items) {
        totalDrinks += order.amount;
      }
    }
    return totalDrinks;
  }

  UnmodifiableListView<OrderCartPayed> get historyCarts {
    final historyCarts = [...historyOrders];
    historyCarts.sort((a, b) => a.date.compareTo(b.date) > 0 ? -1 : 1);
    return UnmodifiableListView(historyCarts);
  }

  UnmodifiableListView<OrderCartPayed> get onGoingCarts {
    final onGoingCarts = [...onGoingOrders];
    onGoingCarts.sort((a, b) => a.date.compareTo(b.date) > 0 ? -1 : 1);
    return UnmodifiableListView(onGoingCarts);
  }

  UnmodifiableListView<OrderCartPayed> get allCarts {
    final allCarts = [...historyOrders, ...onGoingOrders];
    allCarts.sort((a, b) => a.date.compareTo(b.date) > 0 ? -1 : 1);
    return UnmodifiableListView(allCarts);
  }

  UnmodifiableListView<DrinkReward> get drinkRewards {
    final drinkRewards = rewards.whereType<DrinkReward>().toList();
    drinkRewards
        .sort((a, b) => a.validUntil.compareTo(b.validUntil) > 0 ? 1 : -1);
    return UnmodifiableListView(drinkRewards);
  }

  UnmodifiableListView<Voucher> get freeshipVouchers {
    final vouchers = rewards.whereType<FreeshipVoucher>().toList();
    vouchers.sort((a, b) => a.validUntil.compareTo(b.validUntil) > 0 ? 1 : -1);
    return UnmodifiableListView(vouchers);
  }

  UnmodifiableListView<Voucher> get discountVouchers {
    final vouchers = rewards.whereType<DiscountVoucher>().toList();
    vouchers.sort((a, b) => a.validUntil.compareTo(b.validUntil) > 0 ? 1 : -1);
    return UnmodifiableListView(vouchers);
  }

  UnmodifiableListView<RewardBase> get archiveRewards =>
      UnmodifiableListView(inActiveRewards);

  UserModel copyWith({
    String? username,
    String? email,
    String? address,
    String? phone,
    List<OrderCartPayed>? historyOrders,
    List<OrderCartPayed>? onGoingOrders,
    int? points,
    List<RewardBase>? rewards,
    List<RewardBase>? inActiveRewards,
    LoyaltyMembership? tier,
  }) =>
      UserModel(
        username: username ?? this.username,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        historyOrders: historyOrders ?? this.historyOrders,
        onGoingOrders: onGoingOrders ?? this.onGoingOrders,
        totalPoints: points ?? totalPoints,
        tier: tier ?? this.tier,
        rewards: rewards ?? this.rewards,
        inActiveRewards: inActiveRewards ?? this.inActiveRewards,
      );

  @override
  List<Object?> get props => [
        username,
        email,
        address,
        phone,
        historyOrders,
        onGoingOrders,
        totalPoints,
        tier,
        rewards,
        inActiveRewards,
      ];
}
