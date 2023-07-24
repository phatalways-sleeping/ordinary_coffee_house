// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCart _$OrderCartFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['items', 'status'],
  );
  return OrderCart(
    items: (json['items'] as List<dynamic>)
        .map((e) => OrderDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
    status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
        OrderStatus.pending,
  );
}

Map<String, dynamic> _$OrderCartToJson(OrderCart instance) => <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'status': _$OrderStatusEnumMap[instance.status]!,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.processing: 'processing',
  OrderStatus.shipped: 'shipped',
  OrderStatus.delivered: 'delivered',
};

OrderCartPayed _$OrderCartPayedFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['items', 'status', 'price'],
  );
  return OrderCartPayed(
    price: (json['price'] as num).toDouble(),
    items: (json['items'] as List<dynamic>)
        .map((e) => OrderDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
    status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
        OrderStatus.pending,
  );
}

Map<String, dynamic> _$OrderCartPayedToJson(OrderCartPayed instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'status': _$OrderStatusEnumMap[instance.status]!,
      'price': instance.price,
    };
