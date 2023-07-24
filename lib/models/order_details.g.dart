// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'amount',
      'product',
      'shot',
      'drinkType',
      'drinkSize',
      'iceLevel',
      'orderedAt'
    ],
  );
  return OrderDetails(
    id: json['id'] as String,
    amount: json['amount'] as int,
    product: CoffeeProduct.fromJson(json['product'] as Map<String, dynamic>),
    orderedAt:
        ConstDateTime.fromMicrosecondsSinceEpoch(json['orderedAt'] as int),
    shot: $enumDecodeNullable(_$DrinkShotEnumMap, json['shot']) ??
        DrinkShot.single,
    drinkType: $enumDecodeNullable(_$DrinkTypeEnumMap, json['drinkType']) ??
        DrinkType.cold,
    drinkSize: $enumDecodeNullable(_$DrinkSizeEnumMap, json['drinkSize']) ??
        DrinkSize.medium,
    iceLevel: $enumDecodeNullable(_$IceLevelEnumMap, json['iceLevel']) ??
        IceLevel.normal,
  );
}

Map<String, dynamic> _$OrderDetailsToJson(OrderDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'product': instance.product.toJson(),
      'shot': _$DrinkShotEnumMap[instance.shot]!,
      'drinkType': _$DrinkTypeEnumMap[instance.drinkType]!,
      'drinkSize': _$DrinkSizeEnumMap[instance.drinkSize]!,
      'iceLevel': _$IceLevelEnumMap[instance.iceLevel]!,
      'orderedAt': OrderDetails.convertConstDateTimeToJson(instance.orderedAt),
    };

const _$DrinkShotEnumMap = {
  DrinkShot.single: 'single',
  DrinkShot.double: 'double',
};

const _$DrinkTypeEnumMap = {
  DrinkType.hot: 'hot',
  DrinkType.cold: 'cold',
};

const _$DrinkSizeEnumMap = {
  DrinkSize.small: 'small',
  DrinkSize.medium: 'medium',
  DrinkSize.large: 'large',
};

const _$IceLevelEnumMap = {
  IceLevel.none: 'none',
  IceLevel.less: 'less',
  IceLevel.normal: 'normal',
  IceLevel.more: 'more',
};
