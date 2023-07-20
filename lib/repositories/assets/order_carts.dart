import 'package:coffee_order_app/repositories/models/order_cart.dart';

import 'order_details.dart';

const cart1 = OrderCart(
  items: [order1, order2],
  status: OrderStatus.pending,
);

const cart2 = OrderCart(
  items: [order3, order4],
  status: OrderStatus.pending,
);

const cart3 = OrderCart(
  items: [order5, order6],
  status: OrderStatus.processing,
);

const cart4 = OrderCart(
  items: [order7, order8],
  status: OrderStatus.delivered,
);

const cart5 = OrderCart(
  items: [order9, order10],
  status: OrderStatus.delivered,
);

const cart6 = OrderCart(
  items: [order11, order12],
  status: OrderStatus.shipped,
);

const cart7 = OrderCart(
  items: [order13, order14],
  status: OrderStatus.delivered,
);

const cart8 = OrderCart(
  items: [order15, order16],
  status: OrderStatus.delivered,
);

const cart9 = OrderCart(
  items: [order17, order18],
  status: OrderStatus.delivered,
);

const cart10 = OrderCart(
  items: [order19, order20],
  status: OrderStatus.delivered,
);

const historyCarts = [
  cart5,
  cart6,
  cart7,
  cart8,
  cart9,
  cart10,
];

const onGoingCarts = [
  cart1,
  cart2,
  cart3,
  cart4,
];
