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
  bool recustomizeOrderDetailsClicked = false;
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
    if (_instance.orderCart == null) return 0;
    return _instance.orderCart!.items.fold(
      0,
      (previousValue, element) => previousValue + element.price,
    );
  }

  void changeAmount(int amount) {
    assert(_instance.orderDetails != null);
    if (_instance.orderDetails?.product is FreeCoffeeProduct) return;
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

  void checkRecustomizeOrderDetails() {
    recustomizeOrderDetailsClicked = true;
  }

  void unCheckRecustomizeOrderDetails() {
    recustomizeOrderDetailsClicked = false;
  }

  bool get checkRecustomizeOrderDetailsClicked =>
      _instance.recustomizeOrderDetailsClicked;
}
