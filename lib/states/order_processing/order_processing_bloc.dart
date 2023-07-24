import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/models/order_details.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'order_processing_event.dart';
part 'order_processing_state.dart';

class OrderProcessingBloc
    extends Bloc<OrderProcessingEvent, OrderProcessingState> {
  OrderProcessingBloc(this._applicationRepository)
      : super(
          OrderProcessingFullState(
            orderDetails: _applicationRepository.orderDetails!,
          ),
        ) {
    on<AddToCart>((event, emit) {
      _applicationRepository.addToCart();
    });

    on<ChangeAmount>((event, emit) {
      _applicationRepository.changeAmount(event.amount);
      emit(
        OrderProcessingFullState(
          orderDetails: _applicationRepository.orderDetails!,
        ),
      );
    });
    on<ChangeShot>((event, emit) {
      _applicationRepository.changeShot(event.shot);
      emit(
        OrderProcessingFullState(
          orderDetails: _applicationRepository.orderDetails!,
        ),
      );
    });
    on<ChangeSize>((event, emit) {
      _applicationRepository.changeSize(event.size);
      emit(
        OrderProcessingFullState(
          orderDetails: _applicationRepository.orderDetails!,
        ),
      );
    });
    on<ChangeSelect>((event, emit) {
      _applicationRepository.changeSelect(event.type);
      emit(
        OrderProcessingFullState(
          orderDetails: _applicationRepository.orderDetails!,
        ),
      );
    });
    on<ChangeIce>((event, emit) {
      _applicationRepository.changeIce(event.ice);
      emit(
        OrderProcessingFullState(
          orderDetails: _applicationRepository.orderDetails!,
        ),
      );
    });
  }

  final ApplicationRepository _applicationRepository;
}
