// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeshipVoucher _$FreeshipVoucherFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['validUntil'],
  );
  return FreeshipVoucher(
    code: json['code'] as String,
    points: json['points'] as int,
    validUntil:
        ConstDateTime.fromMicrosecondsSinceEpoch(json['validUntil'] as int),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$FreeshipVoucherToJson(FreeshipVoucher instance) =>
    <String, dynamic>{
      'points': instance.points,
      'validUntil': RewardBase.convertConstDateTimeToJson(instance.validUntil),
      'id': instance.id,
      'code': instance.code,
    };

DiscountVoucher _$DiscountVoucherFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['validUntil', 'discount'],
  );
  return DiscountVoucher(
    code: json['code'] as String,
    points: json['points'] as int,
    validUntil:
        ConstDateTime.fromMicrosecondsSinceEpoch(json['validUntil'] as int),
    discount: (json['discount'] as num).toDouble(),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DiscountVoucherToJson(DiscountVoucher instance) =>
    <String, dynamic>{
      'points': instance.points,
      'validUntil': RewardBase.convertConstDateTimeToJson(instance.validUntil),
      'id': instance.id,
      'code': instance.code,
      'discount': instance.discount,
    };

DrinkReward _$DrinkRewardFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['validUntil', 'product'],
  );
  return DrinkReward(
    product: CoffeeProduct.fromJson(json['product'] as Map<String, dynamic>),
    points: json['points'] as int,
    validUntil:
        ConstDateTime.fromMicrosecondsSinceEpoch(json['validUntil'] as int),
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DrinkRewardToJson(DrinkReward instance) =>
    <String, dynamic>{
      'points': instance.points,
      'validUntil': RewardBase.convertConstDateTimeToJson(instance.validUntil),
      'id': instance.id,
      'product': instance.product.toJson(),
    };
