import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'assets/json_error_handling.dart';

part 'loyalty_membership.g.dart';

abstract class LoyaltyMembership extends Equatable {
  final int currentDrinks;
  final int maximumDrinks;
  final LoyaltyMembership? nextTier;

  const LoyaltyMembership({
    this.currentDrinks = 0,
    this.maximumDrinks = 8,
    this.nextTier,
  });

  static Map<String, dynamic> toJson(LoyaltyMembership loyaltyMembership) {
    if (loyaltyMembership is BronzeMembership) {
      return loyaltyMembership.toJson();
    } else if (loyaltyMembership is SilverMembership) {
      return loyaltyMembership.toJson();
    } else if (loyaltyMembership is GoldMembership) {
      return loyaltyMembership.toJson();
    } else if (loyaltyMembership is PremiumMembership) {
      return loyaltyMembership.toJson();
    }

    throw JsonToJsonError('Cannot identify runtype of LoyaltyMembership',
        loyaltyMembership.runtimeType.toString());
  }

  static LoyaltyMembership fromJson(Map<String, dynamic> json) {
    if (json['maximumDrinks'] as int == 8) {
      return BronzeMembership.fromJson(json);
    } else if (json['maximumDrinks'] as int == 15) {
      return SilverMembership.fromJson(json);
    } else if (json['maximumDrinks'] as int == 30) {
      return GoldMembership.fromJson(json);
    } else if (json['maximumDrinks'] as int == 45) {
      return PremiumMembership.fromJson(json);
    }

    throw JsonFromJsonError('Cannot identify Json Type', json.toString());
  }

  LoyaltyMembership copyWith({
    int? currentDrinks,
  });

  @override
  List<Object?> get props => [
        maximumDrinks,
        currentDrinks,
        nextTier,
      ];
}

@JsonSerializable(explicitToJson: true)
class BronzeMembership extends LoyaltyMembership {
  const BronzeMembership({super.currentDrinks = 0})
      : super(
          maximumDrinks: 8,
          nextTier: const SilverMembership(),
        );

  factory BronzeMembership.fromJson(Map<String, dynamic> json) =>
      _$BronzeMembershipFromJson(json);

  Map<String, dynamic> toJson() => _$BronzeMembershipToJson(this);

  @override
  BronzeMembership copyWith({
    int? currentDrinks,
  }) {
    return BronzeMembership(
      currentDrinks: currentDrinks ?? this.currentDrinks,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SilverMembership extends LoyaltyMembership {
  const SilverMembership({super.currentDrinks = 0})
      : super(
          maximumDrinks: 15,
          nextTier: const GoldMembership(),
        );

  factory SilverMembership.fromJson(Map<String, dynamic> json) =>
      _$SilverMembershipFromJson(json);

  Map<String, dynamic> toJson() => _$SilverMembershipToJson(this);
  @override
  SilverMembership copyWith({
    int? currentDrinks,
  }) {
    return SilverMembership(
      currentDrinks: currentDrinks ?? this.currentDrinks,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GoldMembership extends LoyaltyMembership {
  const GoldMembership({super.currentDrinks = 0})
      : super(
          maximumDrinks: 30,
          nextTier: const PremiumMembership(),
        );

  factory GoldMembership.fromJson(Map<String, dynamic> json) =>
      _$GoldMembershipFromJson(json);

  Map<String, dynamic> toJson() => _$GoldMembershipToJson(this);

  @override
  GoldMembership copyWith({
    int? currentDrinks,
  }) {
    return GoldMembership(
      currentDrinks: currentDrinks ?? this.currentDrinks,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PremiumMembership extends LoyaltyMembership {
  const PremiumMembership({super.currentDrinks = 0}) : super(maximumDrinks: 45);

  factory PremiumMembership.fromJson(Map<String, dynamic> json) =>
      _$PremiumMembershipFromJson(json);

  Map<String, dynamic> toJson() => _$PremiumMembershipToJson(this);
  @override
  PremiumMembership copyWith({
    int? currentDrinks,
  }) {
    return PremiumMembership(
      currentDrinks: currentDrinks ?? super.currentDrinks,
    );
  }
}
