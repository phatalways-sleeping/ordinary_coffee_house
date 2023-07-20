import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'loyalty_membership.dart';

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
    this.tier = const BronzeMembership(),
  });

  final String username;
  final String email;
  final String address;
  final String phone;
  final int totalPoints;
  final List<OrderCart> historyOrders;
  final List<OrderCart> onGoingOrders;
  final LoyaltyMembership tier;

  int _aggregatePoints() {
    var totalPoints = 0;
    for (final orderCart in historyOrders) {
      for (final order in orderCart.items) {
        totalPoints += order.product.rewardPoints * order.amount;
      }
    }
    for (final orderCart in onGoingOrders) {
      for (final order in orderCart.items) {
        totalPoints += order.product.rewardPoints * order.amount;
      }
    }
    return totalPoints;
  }

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

  UnmodifiableListView<OrderCart> get historyCarts {
    final historyCarts = [...historyOrders];
    historyCarts.sort((a, b) => a.date.compareTo(b.date) > 0 ? -1 : 1);
    return UnmodifiableListView(historyCarts);
  }

  UnmodifiableListView<OrderCart> get onGoingCarts {
    final onGoingCarts = [...onGoingOrders];
    onGoingCarts.sort((a, b) => a.date.compareTo(b.date)> 0 ? -1 : 1);
    return UnmodifiableListView(onGoingCarts);
  }

  UnmodifiableListView<OrderCart> get allCarts {
    final allCarts = [...historyOrders, ...onGoingOrders];
    allCarts.sort((a, b) => a.date.compareTo(b.date) > 0 ? -1 : 1);
    return UnmodifiableListView(allCarts);
  }

  UserModel copyWith({
    String? username,
    String? email,
    String? address,
    String? phone,
    List<OrderCart>? historyOrders,
    List<OrderCart>? onGoingOrders,
    int? points,
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
      ];
}
