import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/models/order_cart.dart';
import 'package:coffee_order_app/models/runtime_payload.dart';
import 'package:coffee_order_app/repositories/system_api.dart';
import 'package:coffee_order_app/repositories/user_api.dart';

import '../models/order_details.dart';

class ApplicationRepository {
  ApplicationRepository({
    required UserModel user,
    required List<RewardBase> rewards,
    required List<CoffeeProduct> products,
    required RuntimePayload runtimePayload,
  })  : systemAPI = SystemAPI(
          currentUser: user,
          rewards: rewards,
          products: products,
        ),
        userAPI = UserAPI(runtimePayload: runtimePayload, email: user.email);

  static const double freeShipPrice = 2.00;

  Future<void> checkRecustomizeOrderDetails() async {
    await userAPI.checkRecustomizeOrderDetails();
  }

  Future<void> unCheckRecustomizeOrderDetails() async {
    await userAPI.unCheckRecustomizeOrderDetails();
    await userAPI.addToCart();
    await userAPI.clearOrderDetails();
  }

  bool get recustomizeOrderDetailsClicked =>
      userAPI.checkRecustomizeOrderDetailsClicked;

  Future<void> checkOut() async {
    final orderCart = userAPI.runtimePayload.orderCart;
    assert(orderCart != null);

    await systemAPI.addCartToOnGoing(
        OrderCartPayed.from(orderCart!).copyWith(price: price));
    await systemAPI.removeBestDiscountOption();
    await systemAPI.removeBestFreeshipOption();
    await userAPI.checkOut();
  }

  Future<void> levelUp() async {
    await userAPI.levelUp();
  }

  Future<void> addToCart() async {
    await userAPI.addToCart();
    assert(userAPI.runtimePayload.orderDetails != null);
    if (userAPI.runtimePayload.orderDetails!.product is FreeCoffeeProduct) {
      await systemAPI
          .archiveDrinkReward(userAPI.runtimePayload.orderDetails!.product);
    }

    await userAPI.clearOrderDetails();
    assert(userAPI.runtimePayload.orderDetails == null);

    await userAPI.unClick();
  }

  Future<void> removeFromCart(OrderDetails orderDetails) async {
    await userAPI.removeFromCart(orderDetails);
    if (orderDetails.product is FreeCoffeeProduct) {
      systemAPI.popArchiveDrinkReward(orderDetails.product);
    }
  }

  Future<void> recustomizeOrderDetails(OrderDetails orderDetails) async {
    await userAPI.recustomizeOrderDetails(orderDetails);
    await userAPI.checkRecustomizeOrderDetails();
  }

  Future<void> clearOrderDetails() async {
    await userAPI.clearOrderDetails();
  }

  Future<void> customizeOrderDetails(CoffeeProduct coffeeProduct) async {
    await userAPI.customizeOrderDetails(coffeeProduct);
  }

  Future<void> archiveDrinkReward(CoffeeProduct coffeeProduct) async {
    systemAPI.archiveDrinkReward(coffeeProduct);
  }

  Future<void> popArchiveDrinkReward(CoffeeProduct coffeeProduct) async {
    systemAPI.popArchiveDrinkReward(coffeeProduct);
  }

  Future<void> changeAmount(int amount) async {
    await userAPI.changeAmount(amount);
  }

  Future<void> changeShot(DrinkShot shot) async {
    await userAPI.changeShot(shot);
  }

  Future<void> changeSize(DrinkSize size) async {
    await userAPI.changeSize(size);
  }

  Future<void> changeSelect(DrinkType type) async {
    if (type == DrinkType.hot) {
      await userAPI.changeIce(IceLevel.none);
      await userAPI.changeSize(DrinkSize.small);
    } else if (userAPI.runtimePayload.orderDetails!.drinkType ==
            DrinkType.hot &&
        type == DrinkType.cold) {
      await userAPI.changeIce(IceLevel.normal);
      await userAPI.changeSize(DrinkSize.medium);
    }
    await userAPI.changeSelect(type);
  }

  Future<void> changeIce(IceLevel ice) async {
    await userAPI.changeIce(ice);
  }

  Future<void> changeUsername(String name) async {
    await systemAPI.changeUsername(name);
  }

  Future<void> changePhoneNumber(String phoneNumber) async {
    await systemAPI.changePhoneNumber(phoneNumber);
  }

  Future<void> changeEmail(String email) async {
    await systemAPI.changeEmail(email);
    await userAPI.changeEmail(email);
  }

  Future<void> changeAddress(String address) async {
    await systemAPI.changeAddress(address);
  }

  Future<void> claimReward(RewardBase reward) async {
    await systemAPI.claimReward(reward);
  }

  UserModel get currentUser => systemAPI.currentUser;

  List<CoffeeProduct> get products => systemAPI.products;

  double get price => userAPI.price + freeShipPrice - discountPrice;

  double get discountPrice =>
      userAPI.price *
          (bestDiscountOption != null ? bestDiscountOption!.discount : 0.0) +
      (bestFreeshipOption != null ? freeShipPrice : 0.0);

  OrderCart? get orderCart => userAPI.runtimePayload.orderCart;

  OrderDetails? get orderDetails => userAPI.runtimePayload.orderDetails;

  List<DrinkReward> get drinkRewards => systemAPI.drinkRewards;

  List<DrinkReward> get drinkRewardsClaimed => systemAPI.userDrinkRewards;

  List<FreeshipVoucher> get freeshipVouchers => systemAPI.freeshipVouchers;

  List<DiscountVoucher> get discountVoucher => systemAPI.discountVouchers;

  List<RewardBase> get rewards => systemAPI.allRewards;

  DiscountVoucher? get bestDiscountOption =>
      userAPI.runtimePayload.orderCart == null
          ? null
          : userAPI.runtimePayload.orderCart!.items.length == 1 &&
                  userAPI.runtimePayload.orderCart!.items.first.product
                      is FreeCoffeeProduct
              ? null
              : systemAPI.bestDiscountOption;

  FreeshipVoucher? get bestFreeshipOption => systemAPI.bestFreeshipOption;

  bool get clicked => userAPI.runtimePayload.levelUpClicked;

  final SystemAPI systemAPI;
  final UserAPI userAPI;
}
