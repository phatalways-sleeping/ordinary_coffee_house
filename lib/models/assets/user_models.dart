import 'package:coffee_order_app/models/assets/order_carts.dart';
import 'package:coffee_order_app/models/loyalty_membership.dart';
import 'package:coffee_order_app/models/models.dart';

final user = UserModel(
  username: 'Kim Phat Tran',
  email: 'trankimphat@gmail.com',
  address: 'Hoc Mon, Ho Chi Minh City, Vietnam',
  phone: '123-456-7890',
  historyOrders: historyCarts,
  onGoingOrders: onGoingCarts,
  totalPoints: 7250,
  tier: const SilverMembership(),
);
