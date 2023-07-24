// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoffeeProduct _$CoffeeProductFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'price', 'rewardPoints', 'image'],
  );
  return CoffeeProduct(
    name: json['name'] as String,
    description: json['description'] as String?,
    price: (json['price'] as num).toDouble(),
    rewardPoints: json['rewardPoints'] as int,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$CoffeeProductToJson(CoffeeProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'rewardPoints': instance.rewardPoints,
      'image': instance.image,
    };

FreeCoffeeProduct _$FreeCoffeeProductFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'price', 'rewardPoints', 'image'],
  );
  return FreeCoffeeProduct(
    name: json['name'] as String,
    description: json['description'] as String?,
    price: (json['price'] as num).toDouble(),
    rewardPoints: json['rewardPoints'] as int,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$FreeCoffeeProductToJson(FreeCoffeeProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'rewardPoints': instance.rewardPoints,
      'image': instance.image,
    };
