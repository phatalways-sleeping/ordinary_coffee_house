import 'package:coffee_order_app/models/order_details.dart';
import 'package:const_date_time/const_date_time.dart';

import 'coffee_products.dart';

const OrderDetails order1 = OrderDetails(
  orderedAt: ConstDateTime(2023, 7, 1),
  id: "1",
  amount: 2,
  product: espresso,
);

const order2 = OrderDetails(
  orderedAt: ConstDateTime(2023, 7, 1),
  id: "2",
  amount: 1,
  product: cappuccino,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.normal,
);

const order3 = OrderDetails(
  orderedAt: ConstDateTime(2023, 7, 14),
  id: "3",
  amount: 3,
  product: latte,
  drinkType: DrinkType.hot,
  drinkSize: DrinkSize.large,
  iceLevel: IceLevel.less,
);

const order4 = OrderDetails(
  orderedAt: ConstDateTime(2023, 7, 14),
  id: "4",
  amount: 1,
  product: mocha,
  drinkSize: DrinkSize.small,
  iceLevel: IceLevel.normal,
);

const order5 = OrderDetails(
  orderedAt: ConstDateTime(2023, 4, 15),
  id: "5",
  amount: 2,
  product: americano,
  drinkType: DrinkType.hot,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.normal,
);

const order6 = OrderDetails(
  orderedAt: ConstDateTime(2023, 4, 15),
  id: "6",
  amount: 1,
  product: macchiato,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.normal,
);

const order7 = OrderDetails(
  orderedAt: ConstDateTime(2023, 6, 6),
  id: "7",
  amount: 3,
  product: affogato,
  drinkType: DrinkType.cold,
  drinkSize: DrinkSize.large,
  iceLevel: IceLevel.more,
);

const order8 = OrderDetails(
  orderedAt: ConstDateTime(2023, 6, 6),
  id: "8",
  amount: 2,
  product: icedCoffee,
  drinkType: DrinkType.cold,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.normal,
);

const order9 = OrderDetails(
  orderedAt: ConstDateTime(2023, 4, 29),
  id: "9",
  amount: 1,
  product: coldBrew,
  drinkSize: DrinkSize.small,
  iceLevel: IceLevel.normal,
);

const order10 = OrderDetails(
  orderedAt: ConstDateTime(2023, 4, 29),
  id: "10",
  amount: 2,
  product: turkishCoffee,
  drinkType: DrinkType.hot,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.less,
);

const order11 = OrderDetails(
  orderedAt: ConstDateTime(2023, 5, 16),
  id: "11",
  amount: 1,
  product: frenchPress,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.normal,
);

const order12 = OrderDetails(
  orderedAt: ConstDateTime(2023, 5, 16),
  id: "12",
  amount: 2,
  product: cappuccino,
  drinkType: DrinkType.hot,
  drinkSize: DrinkSize.large,
  iceLevel: IceLevel.less,
);

const order13 = OrderDetails(
  orderedAt: ConstDateTime(2023, 5, 20),
  id: "13",
  amount: 1,
  product: mocha,
  drinkSize: DrinkSize.small,
  iceLevel: IceLevel.normal,
);

const order14 = OrderDetails(
  orderedAt: ConstDateTime(2023, 5, 20),
  id: "14",
  amount: 2,
  product: flatWhite,
  drinkType: DrinkType.cold,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.normal,
);

const order15 = OrderDetails(
  orderedAt: ConstDateTime(2023, 1, 12),
  id: "15",
  amount: 1,
  product: espressoConPanna,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.normal,
);

const order16 = OrderDetails(
  orderedAt: ConstDateTime(2023, 1, 12),
  id: "16",
  amount: 3,
  product: americano,
  drinkType: DrinkType.hot,
  drinkSize: DrinkSize.large,
  iceLevel: IceLevel.more,
);

const order17 = OrderDetails(
  orderedAt: ConstDateTime(2022, 12, 31),
  id: "17",
  amount: 2,
  product: turkishCoffee,
  drinkType: DrinkType.cold,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.normal,
);

const order18 = OrderDetails(
  orderedAt: ConstDateTime(2022, 12, 31),
  id: "18",
  amount: 1,
  product: espressoMartini,
  drinkSize: DrinkSize.small,
  iceLevel: IceLevel.normal,
);

const order19 = OrderDetails(
  orderedAt: ConstDateTime(2023, 3, 5),
  id: "19",
  amount: 2,
  product: caramelMacchiato,
  drinkType: DrinkType.hot,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.less,
);

const order20 = OrderDetails(
  orderedAt: ConstDateTime(2023, 3, 5),
  id: "20",
  amount: 1,
  product: flatWhite,
  drinkSize: DrinkSize.medium,
  iceLevel: IceLevel.normal,
);
