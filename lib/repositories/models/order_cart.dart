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

  double totalPrice() => items.fold(
        0,
        (previousValue, element) =>
            previousValue + element.price,
      );

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
