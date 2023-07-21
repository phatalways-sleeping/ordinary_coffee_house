import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';
import 'coffee_product.dart';

abstract class RewardBase extends Equatable {
  const RewardBase({
    required this.points,
    required this.validUntil,
  });

  final int points;
  final ConstDateTime validUntil;

  @override
  List<Object?> get props => [
        points,
        validUntil,
      ];
}

abstract class Voucher extends RewardBase {
  final String code;

  const Voucher({
    required this.code,
    required super.points,
    required super.validUntil,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        code,
      ];
}

class FreeshipVoucher extends Voucher {
  const FreeshipVoucher({
    required super.code,
    required super.points,
    required super.validUntil,
  });

  FreeshipVoucher copyWith({
    String? code,
    int? points,
    ConstDateTime? validUntil,
  }) =>
      FreeshipVoucher(
        code: code ?? this.code,
        points: points ?? this.points,
        validUntil: validUntil ?? this.validUntil,
      );
}

class DiscountVoucher extends Voucher {
  const DiscountVoucher({
    required super.code,
    required super.points,
    required super.validUntil,
    required this.discount,
  });
  final double discount;

  DiscountVoucher copyWith({
    String? code,
    int? points,
    ConstDateTime? validUntil,
    double? discount,
  }) =>
      DiscountVoucher(
        code: code ?? this.code,
        points: points ?? this.points,
        validUntil: validUntil ?? this.validUntil,
        discount: discount ?? this.discount,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        discount,
      ];
}


class DrinkReward extends RewardBase {
  const DrinkReward({
    required this.product,
    required super.points,
    required super.validUntil,
  });
  final CoffeeProduct product;

  DrinkReward copyWith({
    CoffeeProduct? product,
    int? points,
    ConstDateTime? validUntil,
  }) =>
      DrinkReward(
        product: product ?? this.product,
        points: points ?? this.points,
        validUntil: validUntil ?? this.validUntil,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        product,
      ];
}
