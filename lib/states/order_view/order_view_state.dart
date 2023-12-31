part of 'order_view_bloc.dart';

abstract class OrderViewState extends Equatable {
  const OrderViewState({
    required this.historyOrders,
    required this.onGoingOrders,
    required this.currentUser,
    this.viewOnGoing = true,
  });

  final List<OrderCartPayed> historyOrders;
  final List<OrderCartPayed> onGoingOrders;
  final UserModel currentUser;
  final bool viewOnGoing;

  OrderViewState copyWith({
    List<OrderCartPayed>? historyOrders,
    List<OrderCartPayed>? onGoingOrders,
    UserModel? currentUser,
    bool? viewOnGoing,
  });

  @override
  List<Object> get props => [historyOrders, onGoingOrders, currentUser, viewOnGoing];
}

class OrderViewFullState extends OrderViewState {
  const OrderViewFullState({
    required super.historyOrders,
    required super.onGoingOrders,
    required super.currentUser,
    super.viewOnGoing = true,
  });

  @override
  OrderViewFullState copyWith({
    List<OrderCartPayed>? historyOrders,
    List<OrderCartPayed>? onGoingOrders,
    UserModel? currentUser,
    bool? viewOnGoing,
  }) {
    return OrderViewFullState(
      historyOrders: historyOrders ?? this.historyOrders,
      onGoingOrders: onGoingOrders ?? this.onGoingOrders,
      currentUser: currentUser ?? this.currentUser,
      viewOnGoing: viewOnGoing ?? this.viewOnGoing,
    );
  }
}
