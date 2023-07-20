import 'package:equatable/equatable.dart';

abstract class LoyaltyMembership extends Equatable {
  final int currentDrinks;
  final LoyaltyMembership? nextTier;
  static const int drinksPerTier = 8;

  const LoyaltyMembership({
    this.currentDrinks = 0,
    this.nextTier,
  });

  LoyaltyMembership copyWith({
    int? currentDrinks,
  });

  @override
  List<Object?> get props => [
        currentDrinks,
        nextTier,
      ];
}

class BronzeMembership extends LoyaltyMembership {
  const BronzeMembership({super.currentDrinks = 0})
      : super(
          nextTier: const SilverMembership(),
        );

  @override
  BronzeMembership copyWith({
    int? currentDrinks,
  }) {
    return BronzeMembership(
      currentDrinks: currentDrinks ?? this.currentDrinks,
    );
  }
}

class SilverMembership extends LoyaltyMembership {
  const SilverMembership({super.currentDrinks = 0})
      : super(
          nextTier: const GoldMembership(),
        );

  @override
  SilverMembership copyWith({
    int? currentDrinks,
  }) {
    return SilverMembership(
      currentDrinks: currentDrinks ?? this.currentDrinks,
    );
  }
}

class GoldMembership extends LoyaltyMembership {
  const GoldMembership({super.currentDrinks = 0})
      : super(
          nextTier: const PremiumMembership(),
        );

  @override
  GoldMembership copyWith({
    int? currentDrinks,
  }) {
    return GoldMembership(
      currentDrinks: currentDrinks ?? this.currentDrinks,
    );
  }
}

class PremiumMembership extends LoyaltyMembership {
  const PremiumMembership({super.currentDrinks = 0});

  @override
  PremiumMembership copyWith({
    int? currentDrinks,
  }) {
    return PremiumMembership(
      currentDrinks: currentDrinks ?? super.currentDrinks,
    );
  }
}
