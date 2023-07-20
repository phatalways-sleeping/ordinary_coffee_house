part of 'cart_view_bloc.dart';

abstract class CartViewState extends Equatable {
  const CartViewState({required this.orderCart});

  final OrderCart? orderCart;
  @override
  List<Object> get props => [if(orderCart != null) orderCart!];
}

class CartViewNormalState extends CartViewState {
  const CartViewNormalState({required super.orderCart});
}

class CartViewInspectingState extends CartViewState {
  const CartViewInspectingState({
    required super.orderCart,
    required this.orderDetails,
  });

  final OrderDetails orderDetails;

  @override
  List<Object> get props => [...super.props, orderDetails];
}
