import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_details.dart';

part 'order_cart.g.dart';

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
}

@JsonSerializable(explicitToJson: true)
class OrderCart extends Equatable {
  const OrderCart({
    required this.items,
    this.status = OrderStatus.pending,
  });

  factory OrderCart.fromJson(Map<String, dynamic> json) =>
      _$OrderCartFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCartToJson(this);

  @JsonKey(required: true)
  final List<OrderDetails> items;

  @JsonKey(required: true)
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

@JsonSerializable(explicitToJson: true)
class OrderCartPayed extends OrderCart {
  const OrderCartPayed({
    required this.price,
    required super.items,
    required super.status,
  });

  factory OrderCartPayed.fromJson(Map<String, dynamic> json) =>
      _$OrderCartPayedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderCartPayedToJson(this);



  OrderCartPayed.from(OrderCart orderCart)
      : this(
          price: orderCart.items.fold(
            0,
            (previousValue, element) => previousValue + element.price,
          ),
          items: orderCart.items,
          status: orderCart.status,
        );

  @JsonKey(required: true)
  final double price;

  OrderCartPayed copyWith(
      {List<OrderDetails>? items, OrderStatus? status, double? price}) {
    return OrderCartPayed(
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
