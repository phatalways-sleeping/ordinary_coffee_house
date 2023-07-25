// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'username',
      'email',
      'address',
      'phone',
      'totalPoints',
      'historyOrders',
      'onGoingOrders',
      'rewards',
      'inActiveRewards'
    ],
  );
  return UserModel(
    username: json['username'] as String,
    email: json['email'] as String,
    address: json['address'] as String,
    phone: json['phone'] as String,
    historyOrders: (json['historyOrders'] as List<dynamic>)
        .map((e) => OrderCartPayed.fromJson(e as Map<String, dynamic>))
        .toList(),
    onGoingOrders: (json['onGoingOrders'] as List<dynamic>)
        .map((e) => OrderCartPayed.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalPoints: json['totalPoints'] as int,
    rewards: json['rewards'] == null
        ? const []
        : UserModel.rewardListsFromJson(json['rewards'] as List),
    inActiveRewards: json['inActiveRewards'] == null
        ? const []
        : UserModel.rewardListsFromJson(json['inActiveRewards'] as List),
    tier: json['tier'] == null
        ? const BronzeMembership()
        : LoyaltyMembership.fromJson(json['tier'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'totalPoints': instance.totalPoints,
      'historyOrders': instance.historyOrders.map((e) => e.toJson()).toList(),
      'onGoingOrders': instance.onGoingOrders.map((e) => e.toJson()).toList(),
      'rewards': UserModel.rewardListsToJson(instance.rewards),
      'inActiveRewards': UserModel.rewardListsToJson(instance.inActiveRewards),
      'tier': LoyaltyMembership.toJson(instance.tier),
    };
