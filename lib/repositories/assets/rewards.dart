import 'package:coffee_order_app/repositories/models/reward.dart';
import 'package:const_date_time/const_date_time.dart';

import 'coffee_products.dart';

const reward1 = Reward(
  product: espresso,
  points: 1750,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward2 = Reward(
  product: cappuccino,
  points: 1760,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward3 = Reward(
  product: latte,
  points: 1770,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward4 = Reward(
  product: mocha,
  points: 1780,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward5 = Reward(
  product: americano,
  points: 1790,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward6 = Reward(
  product: macchiato,
  points: 100,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward7 = Reward(
  product: affogato,
  points: 1110,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward8 = Reward(
  product: icedCoffee,
  points: 1120,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward9 = Reward(
  product: coldBrew,
  points: 1130,
  validUntil: ConstDateTime(2023, 12, 31),
);

const reward10 = Reward(
  product: turkishCoffee,
  points: 1140,
  validUntil: ConstDateTime(2023, 12, 31),
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
