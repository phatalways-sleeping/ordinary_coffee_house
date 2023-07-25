import 'package:coffee_order_app/models/assets/json_error_handling.dart';
import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'coffee_product.dart';

part 'reward.g.dart';

abstract class RewardBase extends Equatable {
  const RewardBase({
    required this.points,
    required this.validUntil,
    required this.id,
  });

  final int points;
  @JsonKey(
      required: true,
      fromJson: ConstDateTime.fromMicrosecondsSinceEpoch,
      toJson: convertConstDateTimeToJson)
  final ConstDateTime validUntil;
  final String id;

  static Map<String, dynamic> toJson(RewardBase rewardBase) {
    if (rewardBase is DrinkReward) {
      return rewardBase.toJson();
    } else if (rewardBase is FreeshipVoucher) {
      return rewardBase.toJson();
    } else if (rewardBase is DiscountVoucher) {
      return rewardBase.toJson();
    }

    throw JsonToJsonError('Cannot identify runtype of RewardBase',
        rewardBase.runtimeType.toString());
  }

  static RewardBase fromJson(Map<String, dynamic> json) {
    if (json.containsKey('product')) {
      return DrinkReward.fromJson(json);
    } else if (json.containsKey('discount')) {
      return DiscountVoucher.fromJson(json);
    } else if (json.containsKey('code')) {
      return FreeshipVoucher.fromJson(json);
    }

    throw JsonFromJsonError('Cannot identify Json Type', json.toString());
  }

  static int convertConstDateTimeToJson(ConstDateTime validUntil) {
    return validUntil.microsecondsSinceEpoch;
  }

  @override
  List<Object?> get props => [
        points,
        validUntil,
        id,
      ];
}

abstract class Voucher extends RewardBase {
  final String code;

  const Voucher({
    required this.code,
    required super.points,
    required super.validUntil,
    required super.id,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        code,
      ];
}

@JsonSerializable(explicitToJson: true)
class FreeshipVoucher extends Voucher {
  const FreeshipVoucher({
    required super.code,
    required super.points,
    required super.validUntil,
    required super.id,
  });

  factory FreeshipVoucher.fromJson(Map<String, dynamic> json) =>
      _$FreeshipVoucherFromJson(json);

  Map<String, dynamic> toJson() => _$FreeshipVoucherToJson(this);

  FreeshipVoucher copyWith({
    String? code,
    int? points,
    ConstDateTime? validUntil,
    String? id,
  }) =>
      FreeshipVoucher(
        code: code ?? this.code,
        points: points ?? this.points,
        validUntil: validUntil ?? this.validUntil,
        id: id ?? this.id,
      );
}

@JsonSerializable(explicitToJson: true)
class DiscountVoucher extends Voucher {
  const DiscountVoucher({
    required super.code,
    required super.points,
    required super.validUntil,
    required this.discount,
    required super.id,
  });

  @JsonKey(required: true)
  final double discount;

  factory DiscountVoucher.fromJson(Map<String, dynamic> json) =>
      _$DiscountVoucherFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountVoucherToJson(this);

  DiscountVoucher copyWith({
    String? code,
    int? points,
    ConstDateTime? validUntil,
    double? discount,
    String? id,
  }) =>
      DiscountVoucher(
        code: code ?? this.code,
        points: points ?? this.points,
        validUntil: validUntil ?? this.validUntil,
        discount: discount ?? this.discount,
        id: id ?? this.id,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        discount,
      ];
}

@JsonSerializable(explicitToJson: true)
class DrinkReward extends RewardBase {
  const DrinkReward({
    required this.product,
    required super.points,
    required super.validUntil,
    required super.id,
  });

  @JsonKey(required: true)
  final CoffeeProduct product;

  factory DrinkReward.fromJson(Map<String, dynamic> json) =>
      _$DrinkRewardFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkRewardToJson(this);

  DrinkReward copyWith({
    CoffeeProduct? product,
    int? points,
    ConstDateTime? validUntil,
    String? id,
  }) =>
      DrinkReward(
        product: product ?? this.product,
        points: points ?? this.points,
        validUntil: validUntil ?? this.validUntil,
        id: id ?? this.id,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        product,
      ];
}
