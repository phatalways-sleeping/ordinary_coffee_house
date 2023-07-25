import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coffee_product.g.dart';

@JsonSerializable()
class CoffeeProduct extends Equatable {
  @JsonKey(required: true)
  final String name;

  final String? description;

  @JsonKey(required: true)
  final double price;

  @JsonKey(required: true)
  final int rewardPoints;

  @JsonKey(required: true)
  final String image;


  const CoffeeProduct({
    required this.name,
    this.description,
    required this.price,
    required this.rewardPoints,
    required this.image,
  });

  factory CoffeeProduct.fromJson(Map<String, dynamic> json) =>
      _$CoffeeProductFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeProductToJson(this);

  CoffeeProduct copyWith({
    String? name,
    String? description,
    double? price,
    int? rewardPoints,
    String? image,
    String? id,
  }) =>
      CoffeeProduct(
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        rewardPoints: rewardPoints ?? this.rewardPoints,
        image: image ?? this.image,
      );

  @override
  List<Object?> get props => [
        name,
        description,
        price,
        rewardPoints,
        image,
      ];
}

@JsonSerializable()
class FreeCoffeeProduct extends CoffeeProduct {
  const FreeCoffeeProduct({
    required super.name,
    super.description,
    required super.price,
    required super.rewardPoints,
    required super.image,
  });

  factory FreeCoffeeProduct.fromJson(Map<String, dynamic> json) =>
      _$FreeCoffeeProductFromJson(json);

  Map<String, dynamic> toJson() => _$FreeCoffeeProductToJson(this);

  FreeCoffeeProduct.from(CoffeeProduct coffeeProduct)
      : this(
          name: coffeeProduct.name,
          description: coffeeProduct.description,
          price: coffeeProduct.price,
          rewardPoints: coffeeProduct.rewardPoints,
          image: coffeeProduct.image,
        );
}
