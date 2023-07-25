import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/models/order_cart.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

import '../../models/order_details.dart';

part 'cart_view_event.dart';
part 'cart_view_state.dart';

class CartViewBloc extends Bloc<CartViewEvent, CartViewState> {
  CartViewBloc(this._applicationRepository)
      : super(CartViewNormalState(
          orderCart: _applicationRepository.orderCart,
          bestDiscountOption: _applicationRepository.bestDiscountOption,
          bestFreeshipOption: _applicationRepository.bestFreeshipOption,
          discountPrice: _applicationRepository.discountPrice,
        )) {
    on<CheckOut>((event, emit) async {
      await _applicationRepository.checkOut();
      
    });

    on<RemoveFromCart>((event, emit) async {
      await _applicationRepository.removeFromCart(event.orderDetails);
      emit(
        CartViewNormalState(
          orderCart: _applicationRepository.orderCart,
          bestDiscountOption: _applicationRepository.bestDiscountOption,
          bestFreeshipOption: _applicationRepository.bestFreeshipOption,
          discountPrice: _applicationRepository.discountPrice,
        ),
      );
    });

    on<InspectOrder>((event, emit) async {
      await _applicationRepository.recustomizeOrderDetails(event.orderDetails);
      emit(
        CartViewInspectingState(
          orderCart: _applicationRepository.orderCart,
          orderDetails: event.orderDetails,
          bestDiscountOption: _applicationRepository.bestDiscountOption,
          bestFreeshipOption: _applicationRepository.bestFreeshipOption,
          discountPrice: _applicationRepository.discountPrice,
        ),
      );
    });
  }

  final ApplicationRepository _applicationRepository;

  double get totalPrice => _applicationRepository.price;
}
