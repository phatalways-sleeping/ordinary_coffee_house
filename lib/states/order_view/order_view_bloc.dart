import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/repositories/models/models.dart';
import 'package:coffee_order_app/repositories/models/order_cart.dart';
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
  }

  final ApplicationRepository _applicationRepository;
}
