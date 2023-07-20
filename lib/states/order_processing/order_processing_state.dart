part of 'order_processing_bloc.dart';

abstract class OrderProcessingState extends Equatable {
  const OrderProcessingState({
    required this.orderDetails,
  });

  final OrderDetails orderDetails;

  OrderProcessingState copyWith({
    OrderDetails? orderDetails,
  });

  @override
  List<Object> get props => [orderDetails];
}

class OrderProcessingFullState extends OrderProcessingState {
  const OrderProcessingFullState({
    required super.orderDetails,
  });

  @override
  OrderProcessingFullState copyWith({
    OrderDetails? orderDetails,
  }) {
    return OrderProcessingFullState(
      orderDetails: orderDetails ?? this.orderDetails,
    );
  }
}
