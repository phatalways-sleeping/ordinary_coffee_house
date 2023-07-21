import 'package:coffee_order_app/repositories/models/models.dart';
import 'package:coffee_order_app/repositories/models/order_cart.dart';
import 'package:coffee_order_app/repositories/models/order_details.dart';

class UserRepository {
  UserRepository._({
    this.orderDetails,
  });

  OrderDetails? orderDetails;
  OrderCart? orderCart;
  bool levelUpClicked = false;
  static final UserRepository _instance = UserRepository._();

  static UserRepository get instance => _instance;

  void customizeOrderDetails(CoffeeProduct coffeeProduct) {
    _instance.orderDetails = OrderDetails.deflt(product: coffeeProduct);
  }

  void checkOut() {
    orderCart = null;
  }

  void levelUp() {
    levelUpClicked = true;
  }

  void unClick() {
    levelUpClicked = false;
  }

  void addToCart() {
    if (_instance.orderCart == null) {
      _instance.orderCart = OrderCart(items: [_instance.orderDetails!]);
    } else {
      _instance.orderCart = _instance.orderCart!.copyWith(
        items: [..._instance.orderCart!.items, _instance.orderDetails!],
      );
    }
    clearOrderDetails();
    unClick();
  }

  void removeFromCart(OrderDetails orderDetails) {
    assert(_instance.orderCart != null);
    _instance.orderCart = _instance.orderCart!.copyWith(
      items: _instance.orderCart!.items
          .where((element) => element != orderDetails)
          .toList(),
    );
  }

  void recustomizeOrderDetails(OrderDetails orderDetails) {
    assert(_instance.orderCart != null);
    _instance.orderCart = _instance.orderCart!.copyWith(
        items: _instance.orderCart!.items
            .where((element) => element != orderDetails)
            .toList());
    _instance.orderDetails = orderDetails;
  }

  void clearOrderDetails() {
    _instance.orderDetails = null;
  }

  double get price {
    assert(_instance.orderCart != null);
    double price = 0;
    for (final orderDetail in _instance.orderCart!.items) {
      price += orderDetail.price * orderDetail.amount;
    }
    return price;
  }

  void changeAmount(int amount) {
    assert(_instance.orderDetails != null);
    _instance.orderDetails = _instance.orderDetails!.copyWith(
        amount: _instance.orderDetails!.amount + amount == 0
            ? _instance.orderDetails!.amount
            : _instance.orderDetails!.amount + amount);
  }

  void changeShot(DrinkShot shot) {
    assert(_instance.orderDetails != null);
    _instance.orderDetails = _instance.orderDetails!.copyWith(shot: shot);
  }

  void changeSize(DrinkSize size) {
    assert(_instance.orderDetails != null);
    _instance.orderDetails = _instance.orderDetails!.copyWith(drinkSize: size);
  }

  void changeSelect(DrinkType type) {
    assert(_instance.orderDetails != null);
    _instance.orderDetails = _instance.orderDetails!.copyWith(drinkType: type);
  }

  void changeIce(IceLevel ice) {
    assert(_instance.orderDetails != null);
    _instance.orderDetails = _instance.orderDetails!.copyWith(iceLevel: ice);
  }
}
