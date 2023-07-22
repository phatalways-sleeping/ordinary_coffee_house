import 'package:coffee_order_app/repositories/assets/assets.dart';
import 'package:coffee_order_app/repositories/models/models.dart';
import 'package:coffee_order_app/repositories/models/order_cart.dart';
import 'package:coffee_order_app/repositories/system_repository.dart';
import 'package:coffee_order_app/repositories/user_repository.dart';

import 'models/order_details.dart';

class ApplicationRepository {
  ApplicationRepository._({
    required this.systemRepository,
    required this.userRepository,
  });

  static final ApplicationRepository instance = ApplicationRepository._(
    systemRepository: SystemRepository.mockRepository,
    userRepository: UserRepository.instance,
  );

  static const double freeShipPrice = 2.00;

  void checkRecustomizeOrderDetails() {
    userRepository.checkRecustomizeOrderDetails();
  }

  void unCheckRecustomizeOrderDetails() {
    userRepository.unCheckRecustomizeOrderDetails();
    userRepository.addToCart();
    userRepository.clearOrderDetails();
  }

  bool get recustomizeOrderDetailsClicked =>
      userRepository.checkRecustomizeOrderDetailsClicked;

  void checkOut() {
    final orderCart = userRepository.orderCart;
    assert(orderCart != null);

    systemRepository.addCartToOnGoing(
        OrderCartPayed.from(orderCart!).copyWith(price: price));
    userRepository.checkOut();
  }

  void levelUp() {
    userRepository.levelUp();
  }

  void addToCart() {
    userRepository.addToCart();
    assert(userRepository.orderDetails != null);
    if (userRepository.orderDetails!.product is FreeCoffeeProduct) {
      systemRepository.archiveDrinkReward(userRepository.orderDetails!.product);
    }

    userRepository.clearOrderDetails();
    assert(userRepository.orderDetails == null);

    userRepository.unClick();
  }

  void removeFromCart(OrderDetails orderDetails) {
    userRepository.removeFromCart(orderDetails);
    if (orderDetails.product is FreeCoffeeProduct) {
      systemRepository.popArchiveDrinkReward(orderDetails.product);
    }
  }

  void recustomizeOrderDetails(OrderDetails orderDetails) {
    userRepository.recustomizeOrderDetails(orderDetails);
    userRepository.checkRecustomizeOrderDetails();
  }

  void clearOrderDetails() {
    userRepository.clearOrderDetails();
  }

  void customizeOrderDetails(CoffeeProduct coffeeProduct) {
    userRepository.customizeOrderDetails(coffeeProduct);
  }

  void archiveDrinkReward(CoffeeProduct coffeeProduct) {
    systemRepository.archiveDrinkReward(coffeeProduct);
  }

  void popArchiveDrinkReward(CoffeeProduct coffeeProduct) {
    systemRepository.popArchiveDrinkReward(coffeeProduct);
  }

  void changeAmount(int amount) {
    userRepository.changeAmount(amount);
  }

  void changeShot(DrinkShot shot) {
    userRepository.changeShot(shot);
  }

  void changeSize(DrinkSize size) {
    userRepository.changeSize(size);
  }

  void changeSelect(DrinkType type) {
    if (type == DrinkType.hot) {
      userRepository.changeIce(IceLevel.none);
      userRepository.changeSize(DrinkSize.small);
    } else if (userRepository.orderDetails!.drinkType == DrinkType.hot &&
        type == DrinkType.cold) {
      userRepository.changeIce(IceLevel.normal);
      userRepository.changeSize(DrinkSize.medium);
    }
    userRepository.changeSelect(type);
  }

  void changeIce(IceLevel ice) {
    userRepository.changeIce(ice);
  }

  void changeUsername(String name) {
    systemRepository.changeUsername(name);
  }

  void changePhoneNumber(String phoneNumber) {
    systemRepository.changePhoneNumber(phoneNumber);
  }

  void changeEmail(String email) {
    systemRepository.changeEmail(email);
  }

  void changeAddress(String address) {
    systemRepository.changeAddress(address);
  }

  void claimReward(RewardBase reward) {
    systemRepository.claimReward(reward);
  }

  UserModel get currentUser => systemRepository.currentUser;

  List<CoffeeProduct> get products => systemRepository.products;

  double get price => userRepository.price + freeShipPrice - discountPrice;

  double get discountPrice =>
      userRepository.price *
          (bestDiscountOption != null ? bestDiscountOption!.discount : 0.0) +
      (bestFreeshipOption != null ? freeShipPrice : 0.0);

  OrderCart? get orderCart => userRepository.orderCart;

  OrderDetails? get orderDetails => userRepository.orderDetails;

  List<DrinkReward> get drinkRewards => systemRepository.drinkRewards;

  List<DrinkReward> get drinkRewardsClaimed =>
      systemRepository.userDrinkRewards;

  List<FreeshipVoucher> get freeshipVouchers =>
      systemRepository.freeshipVouchers;

  List<DiscountVoucher> get discountVoucher =>
      systemRepository.discountVouchers;

  List<RewardBase> get rewards => systemRepository.allRewards;

  DiscountVoucher? get bestDiscountOption => userRepository.orderCart == null ? null :
      userRepository.orderCart!.items.length == 1 &&
              userRepository.orderCart!.items.first.product is FreeCoffeeProduct
          ? null
          : systemRepository.bestDiscountOption;

  FreeshipVoucher? get bestFreeshipOption =>
      systemRepository.bestFreeshipOption;

  bool get clicked => userRepository.levelUpClicked;

  final SystemRepository systemRepository;
  final UserRepository userRepository;
}
