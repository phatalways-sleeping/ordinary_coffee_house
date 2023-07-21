import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';

import 'order_details.dart';

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
}

class OrderCart extends Equatable {
  const OrderCart({
    required this.items,
    this.status = OrderStatus.pending,
  });
  final List<OrderDetails> items;
  final OrderStatus status;

  ConstDateTime get date => items.first.orderedAt;

  int get totalPoints => items.fold(
        0,
        (previousValue, element) =>
            previousValue + element.amount * element.product.rewardPoints,
      );

  OrderCart copyWith({
    List<OrderDetails>? items,
    OrderStatus? status,
  }) =>
      OrderCart(
        items: items ?? this.items,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        items,
        status,
      ];
}

class OrderCartPayed extends OrderCart {
  const OrderCartPayed._({
    required this.price,
    required super.items,
    required super.status,
  });

  OrderCartPayed.from(OrderCart orderCart)
      : this._(
          price: orderCart.items.fold(
            0,
            (previousValue, element) => previousValue + element.price,
          ),
          items: orderCart.items,
          status: orderCart.status,
        );

  final double price;

  OrderCartPayed copyWith(
      {List<OrderDetails>? items, OrderStatus? status, double? price}) {
    return OrderCartPayed._(
      price: price ?? this.price,
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        price,
        ...super.props,
      ];
}
