import 'package:equatable/equatable.dart';

class CoffeeProduct extends Equatable {
  final String name;
  final String? description;
  final double price;
  final int rewardPoints;
  final String image;

  const CoffeeProduct({
    required this.name,
    this.description,
    required this.price,
    required this.rewardPoints,
    required this.image,
  });

  CoffeeProduct copyWith({
    String? name,
    String? description,
    double? price,
    int? rewardPoints,
    String? image,
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

class FreeCoffeeProduct extends CoffeeProduct {
  const FreeCoffeeProduct({
    required super.name,
    super.description,
    required super.price,
    required super.rewardPoints,
    required super.image,
  });

  FreeCoffeeProduct.from(CoffeeProduct coffeeProduct)
      : this(
          name: coffeeProduct.name,
          description: coffeeProduct.description,
          price: coffeeProduct.price,
          rewardPoints: coffeeProduct.rewardPoints,
          image: coffeeProduct.image,
        );
}
