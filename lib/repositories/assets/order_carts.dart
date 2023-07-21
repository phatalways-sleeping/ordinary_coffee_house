import 'package:coffee_order_app/repositories/models/order_cart.dart';

import 'order_details.dart';

final cart1 = OrderCartPayed.from(const OrderCart(
  items: [order1, order2],
  status: OrderStatus.pending,
));

final cart2 = OrderCartPayed.from(const OrderCart(
  items: [order3, order4],
  status: OrderStatus.pending,
));

final cart3 = OrderCartPayed.from(const OrderCart(
  items: [order5, order6],
  status: OrderStatus.processing,
));

final cart4 = OrderCartPayed.from(const OrderCart(
  items: [order7, order8],
  status: OrderStatus.delivered,
));

final cart5 = OrderCartPayed.from(const OrderCart(
  items: [order9, order10],
  status: OrderStatus.delivered,
));

final cart6 = OrderCartPayed.from(const OrderCart(
  items: [order11, order12],
  status: OrderStatus.shipped,
));

final cart7 = OrderCartPayed.from(const OrderCart(
  items: [order13, order14],
  status: OrderStatus.delivered,
));

final cart8 = OrderCartPayed.from(const OrderCart(
  items: [order15, order16],
  status: OrderStatus.delivered,
));

final cart9 = OrderCartPayed.from(const OrderCart(
  items: [order17, order18],
  status: OrderStatus.delivered,
));

final cart10 = OrderCartPayed.from(const OrderCart(
  items: [order19, order20],
  status: OrderStatus.delivered,
));

final historyCarts = [
  cart5,
  cart6,
  cart7,
  cart8,
  cart9,
  cart10,
];

final onGoingCarts = [
  cart1,
  cart2,
  cart3,
  cart4,
];
