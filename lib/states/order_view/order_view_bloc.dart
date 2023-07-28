import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/models/order_cart.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'order_view_event.dart';
part 'order_view_state.dart';

class OrderViewBloc extends Bloc<OrderViewEvent, OrderViewState> {
  OrderViewBloc(this._applicationRepository)
      : super(OrderViewFullState(
          historyOrders: _applicationRepository.currentUser.historyCarts,
          onGoingOrders: _applicationRepository.currentUser.onGoingCarts,
          currentUser: _applicationRepository.currentUser,
        )) {
    on<ChangeView>((event, emit) {
      emit(state.copyWith(viewOnGoing: event.viewOnGoing));
    });

    on<AddCartToHistory>((event, emit) async {
      await _applicationRepository.addCartToHistory(event.orderCart);
      emit(state.copyWith(
        historyOrders: _applicationRepository.currentUser.historyCarts,
        onGoingOrders: _applicationRepository.currentUser.onGoingCarts,
      ));
    });
  }

  final ApplicationRepository _applicationRepository;

  double get totalPrice => _applicationRepository.price;
}
