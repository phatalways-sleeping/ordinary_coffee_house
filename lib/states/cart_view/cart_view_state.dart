part of 'cart_view_bloc.dart';

abstract class CartViewState extends Equatable {
  const CartViewState({
    required this.orderCart,
    this.bestDiscountOption,
    this.bestFreeshipOption,
    required this.discountPrice,
    this.freeShipPrice = 2.00,
  });

  final OrderCart? orderCart;
  final DiscountVoucher? bestDiscountOption;
  final FreeshipVoucher? bestFreeshipOption;
  final double discountPrice;
  final double freeShipPrice;
  @override
  List<Object> get props => [
        discountPrice,
        freeShipPrice,
        if (orderCart != null) orderCart!,
        if (bestDiscountOption != null) bestDiscountOption!,
        if (bestFreeshipOption != null) bestFreeshipOption!,
      ];
}

class CartViewNormalState extends CartViewState {
  const CartViewNormalState({
    required super.discountPrice,
    required super.orderCart,
    required super.bestDiscountOption,
    required super.bestFreeshipOption,
    super.freeShipPrice = 2.00,
  });
}

class CartViewInspectingState extends CartViewState {
  const CartViewInspectingState({
    required super.discountPrice,
    required super.orderCart,
    required super.bestDiscountOption,
    required super.bestFreeshipOption,
    required this.orderDetails,
    super.freeShipPrice = 2.00,
  });

  final OrderDetails orderDetails;

  @override
  List<Object> get props => [...super.props, orderDetails];
}
