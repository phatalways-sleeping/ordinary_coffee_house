import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';
import 'coffee_product.dart';

class Reward extends Equatable {
  const Reward({
    required this.product,
    required this.points,
    required this.validUntil,
  });
  final CoffeeProduct product;
  final int points;
  final ConstDateTime validUntil;

  Reward copyWith({
    CoffeeProduct? product,
    int? points,
    ConstDateTime? validUntil,
  }) =>
      Reward(
        product: product ?? this.product,
        points: points ?? this.points,
        validUntil: validUntil ?? this.validUntil,
      );

  @override
  List<Object?> get props => [
        product,
        points,
        validUntil,
      ];
}
