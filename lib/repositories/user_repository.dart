import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/models/order_cart.dart';
import 'package:coffee_order_app/models/order_details.dart';
import 'package:coffee_order_app/models/runtime_payload.dart';

class UserRepository {
  UserRepository({
    required this.runtimePayload,
  });

  RuntimePayload runtimePayload;

  void customizeOrderDetails(CoffeeProduct coffeeProduct) {
    runtimePayload = runtimePayload.copyWith(
        orderDetails: OrderDetails.deflt(product: coffeeProduct));
  }

  void checkOut() {
    runtimePayload = runtimePayload.copyWith(orderCart: null);
  }

  void levelUp() {
    runtimePayload = runtimePayload.copyWith(levelUpClicked: true);
  }

  void unClick() {
    runtimePayload = runtimePayload.copyWith(levelUpClicked: false);
  }

  void addToCart() {
    if (runtimePayload.orderCart == null) {
      runtimePayload = runtimePayload.copyWith(
          orderCart: OrderCart(items: [runtimePayload.orderDetails!]));
    } else {
      runtimePayload = runtimePayload.copyWith(
          orderCart: runtimePayload.orderCart!.copyWith(items: [
        ...runtimePayload.orderCart!.items,
        runtimePayload.orderDetails!
      ]));
    }
  }

  void removeFromCart(OrderDetails orderDetails) {
    assert(runtimePayload.orderCart != null);
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart!.copyWith(
            items: runtimePayload.orderCart!.items
                .where((element) => element != orderDetails)
                .toList()));
  }

  void recustomizeOrderDetails(OrderDetails orderDetails) {
    assert(runtimePayload.orderCart != null);
    runtimePayload = runtimePayload.copyWith(
        orderCart: runtimePayload.orderCart!.copyWith(
            items: runtimePayload.orderCart!.items
                .where((element) => element != orderDetails)
                .toList()),
        orderDetails: orderDetails);
  }

  void clearOrderDetails() {
    runtimePayload = runtimePayload.copyWith(orderDetails: null);
  }

  double get price {
    if (runtimePayload.orderCart == null) return 0;
    return runtimePayload.orderCart!.items.fold(
      0,
      (previousValue, element) => previousValue + element.price,
    );
  }

  void changeAmount(int amount) {
    assert(runtimePayload.orderDetails != null);
    if (runtimePayload.orderDetails?.product is FreeCoffeeProduct) return;
    runtimePayload = runtimePayload.copyWith(
        orderDetails: runtimePayload.orderDetails!.copyWith(
            amount: runtimePayload.orderDetails!.amount + amount == 0
                ? runtimePayload.orderDetails!.amount
                : runtimePayload.orderDetails!.amount + amount));
  }

  void changeShot(DrinkShot shot) {
    assert(runtimePayload.orderDetails != null);
    runtimePayload = runtimePayload.copyWith(
        orderDetails: runtimePayload.orderDetails!.copyWith(shot: shot));
  }

  void changeSize(DrinkSize size) {
    assert(runtimePayload.orderDetails != null);
    runtimePayload = runtimePayload.copyWith(
        orderDetails: runtimePayload.orderDetails!.copyWith(drinkSize: size));
  }

  void changeSelect(DrinkType type) {
    assert(runtimePayload.orderDetails != null);
    runtimePayload = runtimePayload.copyWith(
        orderDetails: runtimePayload.orderDetails!.copyWith(drinkType: type));
  }

  void changeIce(IceLevel ice) {
    assert(runtimePayload.orderDetails != null);
    runtimePayload = runtimePayload.copyWith(
        orderDetails: runtimePayload.orderDetails!.copyWith(iceLevel: ice));
  }

  void checkRecustomizeOrderDetails() {
    runtimePayload = runtimePayload.copyWith(
      recustomizeOrderDetailsClicked: true,
    );
  }

  void unCheckRecustomizeOrderDetails() {
    runtimePayload = runtimePayload.copyWith(
      recustomizeOrderDetailsClicked: false,
    );
  }

  bool get checkRecustomizeOrderDetailsClicked =>
      runtimePayload.recustomizeOrderDetailsClicked;
}
