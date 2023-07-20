part of 'cart_view_bloc.dart';

abstract class CartViewEvent extends Equatable {
  const CartViewEvent();

  @override
  List<Object> get props => [];
}

class RemoveFromCart extends CartViewEvent {
  const RemoveFromCart(this.orderDetails);

  final OrderDetails orderDetails;
}

class InspectOrder extends CartViewEvent {
  const InspectOrder(this.orderDetails);

  final OrderDetails orderDetails;
}

class CheckOut extends CartViewEvent {
  const CheckOut();
}