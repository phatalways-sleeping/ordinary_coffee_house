import 'package:coffee_order_app/models/order_cart.dart';
import 'package:coffee_order_app/models/order_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'runtime_payload.g.dart';

@JsonSerializable(explicitToJson: true)
class RuntimePayload {
  RuntimePayload({
    required this.orderDetails,
    required this.orderCart,
    this.levelUpClicked = false,
    this.recustomizeOrderDetailsClicked = false,
  });

  factory RuntimePayload.fromJson(Map<String, dynamic> json) =>
      _$RuntimePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$RuntimePayloadToJson(this);

  @JsonKey()
  final OrderDetails? orderDetails;
  @JsonKey()
  final OrderCart? orderCart;
  @JsonKey(defaultValue: false)
  final bool levelUpClicked;
  @JsonKey(defaultValue: false)
  final bool recustomizeOrderDetailsClicked;

  RuntimePayload copyWith({
    OrderDetails? orderDetails,
    OrderCart? orderCart,
    bool? levelUpClicked,
    bool? recustomizeOrderDetailsClicked,
  }) =>
      RuntimePayload(
        orderDetails: orderDetails ?? this.orderDetails,
        orderCart: orderCart ?? this.orderCart,
        levelUpClicked: levelUpClicked ?? this.levelUpClicked,
        recustomizeOrderDetailsClicked: recustomizeOrderDetailsClicked ??
            this.recustomizeOrderDetailsClicked,
      );
}
