import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/repositories/models/order_cart.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/models/order_details.dart';

part 'cart_view_event.dart';
part 'cart_view_state.dart';

class CartViewBloc extends Bloc<CartViewEvent, CartViewState> {
  CartViewBloc(this._applicationRepository)
      : super(CartViewNormalState(
            orderCart: _applicationRepository.orderCart)) {
    on<CheckOut>((event, emit) {
      _applicationRepository.checkOut();
    });
    
    on<RemoveFromCart>((event, emit) {
      _applicationRepository.removeFromCart(event.orderDetails);
      emit(
        CartViewNormalState(
            orderCart: _applicationRepository.orderCart),
      );
    });

    on<InspectOrder>((event, emit) {
      emit(
        CartViewInspectingState(
          orderCart: _applicationRepository.orderCart,
          orderDetails: event.orderDetails,
        ),
      );
    });
  }

  final ApplicationRepository _applicationRepository;
}
