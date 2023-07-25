import 'package:coffee_order_app/models/reward.dart';
import 'package:const_date_time/const_date_time.dart';
import 'package:uuid/uuid.dart';

import 'coffee_products.dart';

final reward1 = DrinkReward(
  id: const Uuid().v4(),
  product: espresso,
  points: 1750,
  validUntil: ConstDateTime(2023, 12, 31),
);

final reward2 = DrinkReward(
  id: const Uuid().v4(),
  product: cappuccino,
  points: 1760,
  validUntil: ConstDateTime(2023, 12, 31),
);

final reward3 = DrinkReward(
  id: const Uuid().v4(),
  product: latte,
  points: 1770,
  validUntil: ConstDateTime(2023, 12, 31),
);

final reward4 = DrinkReward(
  id: const Uuid().v4(),
  product: mocha,
  points: 1780,
  validUntil: ConstDateTime(2023, 12, 31),
);

final reward5 = DrinkReward(
  id: const Uuid().v4(),
  product: americano,
  points: 1790,
  validUntil: ConstDateTime(2023, 12, 31),
);

final reward6 = DrinkReward(
  id: const Uuid().v4(),
  product: macchiato,
  points: 100,
  validUntil: ConstDateTime(2023, 12, 31),
);

final reward7 = DrinkReward(
  id: const Uuid().v4(),
  product: affogato,
  points: 1110,
  validUntil: ConstDateTime(2023, 12, 31),
);

final reward8 = DrinkReward(
  id: const Uuid().v4(),
  product: icedCoffee,
  points: 1120,
  validUntil: ConstDateTime(2023, 12, 31),
);

final reward9 = DrinkReward(
  id: const Uuid().v4(),
  product: coldBrew,
  points: 1130,
  validUntil: ConstDateTime(2023, 12, 31),
);

final reward10 = DrinkReward(
  id: const Uuid().v4(),
  product: turkishCoffee,
  points: 1140,
  validUntil: ConstDateTime(2023, 12, 31),
);

final freeship1 = FreeshipVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 100,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship2 = FreeshipVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 100,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship3 = FreeshipVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 100,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship4 = FreeshipVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 150,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship5 = FreeshipVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 150,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship6 = FreeshipVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 150,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship7 = FreeshipVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 200,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final discountVoucher1 = DiscountVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 300,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.2,
);

final discountVoucher2 = DiscountVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 1000,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 1.0,
);

final discountVoucher3 = DiscountVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 400,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.4,
);

final discountVoucher4 = DiscountVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 500,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.5,
);

final discountVoucher5 = DiscountVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 600,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.6,
);

final discountVoucher6 = DiscountVoucher(
  id: const Uuid().v4(),
  code: const Uuid().v4(),
  points: 700,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.7,
);

final currentRewards = [
  reward1,
  reward2,
  reward3,
  reward4,
  reward5,
  reward6,
  reward7,
  reward8,
  reward9,
  reward10,
];

final currentVouchers = [
  freeship1,
  freeship2,
  freeship3,
  freeship4,
  freeship5,
  freeship6,
  freeship7,
  discountVoucher1,
  discountVoucher2,
  discountVoucher3,
  discountVoucher4,
  discountVoucher5,
  discountVoucher6,
];
