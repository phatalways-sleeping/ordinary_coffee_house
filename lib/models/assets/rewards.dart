import 'package:coffee_order_app/models/reward.dart';
import 'package:const_date_time/const_date_time.dart';
import 'package:uuid/uuid.dart';

import 'coffee_products.dart';

const reward1 = DrinkReward(
  product: espresso,
  points: 1750,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward2 = DrinkReward(
  product: cappuccino,
  points: 1760,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward3 = DrinkReward(
  product: latte,
  points: 1770,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward4 = DrinkReward(
  product: mocha,
  points: 1780,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward5 = DrinkReward(
  product: americano,
  points: 1790,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward6 = DrinkReward(
  product: macchiato,
  points: 100,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward7 = DrinkReward(
  product: affogato,
  points: 1110,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward8 = DrinkReward(
  product: icedCoffee,
  points: 1120,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward9 = DrinkReward(
  product: coldBrew,
  points: 1130,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward10 = DrinkReward(
  product: turkishCoffee,
  points: 1140,
  validUntil: ConstDateTime(2023, 12, 31),
);

final freeship1 = FreeshipVoucher(
  code: const Uuid().v4(),
  points: 100,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship2 = FreeshipVoucher(
  code: const Uuid().v4(),
  points: 100,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship3 = FreeshipVoucher(
  code: const Uuid().v4(),
  points: 100,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship4 = FreeshipVoucher(
  code: const Uuid().v4(),
  points: 150,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship5 = FreeshipVoucher(
  code: const Uuid().v4(),
  points: 150,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship6 = FreeshipVoucher(
  code: const Uuid().v4(),
  points: 150,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final freeship7 = FreeshipVoucher(
  code: const Uuid().v4(),
  points: 200,
  validUntil: const ConstDateTime(2023, 12, 31),
);

final discountVoucher1 = DiscountVoucher(
  code: const Uuid().v4(),
  points: 300,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.2,
);

final discountVoucher2 = DiscountVoucher(
  code: const Uuid().v4(),
  points: 1000,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 1.0,
);

final discountVoucher3 = DiscountVoucher(
  code: const Uuid().v4(),
  points: 400,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.4,
);

final discountVoucher4 = DiscountVoucher(
  code: const Uuid().v4(),
  points: 500,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.5,
);

final discountVoucher5 = DiscountVoucher(
  code: const Uuid().v4(),
  points: 600,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.6,
);

final discountVoucher6 = DiscountVoucher(
  code: const Uuid().v4(),
  points: 700,
  validUntil: const ConstDateTime(2023, 12, 31),
  discount: 0.7,
);

const currentRewards = [
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
