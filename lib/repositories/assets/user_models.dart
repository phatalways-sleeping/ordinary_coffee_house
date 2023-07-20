import 'package:coffee_order_app/repositories/assets/order_carts.dart';
import 'package:coffee_order_app/repositories/models/loyalty_membership.dart';
import 'package:coffee_order_app/repositories/models/models.dart';

const user = UserModel(
  username: 'John Doe',
  email: 'johndoe@gmail.com',
  address: '1234 Main St, New York, NY 10030',
  phone: '123-456-7890',
  historyOrders: historyCarts,
  onGoingOrders: onGoingCarts,
  totalPoints: 1250,
  tier: SilverMembership(),
);
