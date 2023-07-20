import 'package:coffee_order_app/repositories/assets/assets.dart';
import 'package:coffee_order_app/repositories/models/models.dart';
import 'package:coffee_order_app/repositories/models/order_cart.dart';

class SystemRepository {
  SystemRepository._({
    required this.currentUser,
    required this.products,
    required this.rewards,
  });

  static final SystemRepository _instance = SystemRepository._(
    currentUser: user,
    products: coffeeProducts,
    rewards: currentRewards,
  );

  static SystemRepository get mockRepository => _instance;

  UserModel currentUser;
  final List<CoffeeProduct> products;
  List<Reward> rewards;

  void changeUsername(String newUsername) {
    currentUser = currentUser.copyWith(username: newUsername);
  }

  void changePhoneNumber(String newPhoneNumber) {
    currentUser = currentUser.copyWith(phone: newPhoneNumber);
  }

  void changeEmail(String newEmail) {
    currentUser = currentUser.copyWith(email: newEmail);
  }

  void changeAddress(String newAddress) {
    currentUser = currentUser.copyWith(address: newAddress);
  }

  void claimReward(Reward reward) {
    rewards = rewards
        .where(
          (element) => element != reward,
        )
        .toList();
    currentUser = currentUser.copyWith(
      points: currentUser.totalPoints - reward.points,
    );
  }

  void addCartToOnGoing(OrderCart orderCart) {
    currentUser = currentUser.copyWith(
      points: currentUser.totalPoints + orderCart.totalPoints,
      onGoingOrders: [...currentUser.onGoingOrders, orderCart],
    );
  }
}
