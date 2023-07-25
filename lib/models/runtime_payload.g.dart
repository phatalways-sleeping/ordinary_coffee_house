// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runtime_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuntimePayload _$RuntimePayloadFromJson(Map<String, dynamic> json) =>
    RuntimePayload(
      orderDetails: json['orderDetails'] == null
          ? null
          : OrderDetails.fromJson(json['orderDetails'] as Map<String, dynamic>),
      orderCart: json['orderCart'] == null
          ? null
          : OrderCart.fromJson(json['orderCart'] as Map<String, dynamic>),
      levelUpClicked: json['levelUpClicked'] as bool? ?? false,
      recustomizeOrderDetailsClicked:
          json['recustomizeOrderDetailsClicked'] as bool? ?? false,
    );

Map<String, dynamic> _$RuntimePayloadToJson(RuntimePayload instance) =>
    <String, dynamic>{
      'orderDetails': instance.orderDetails?.toJson(),
      'orderCart': instance.orderCart?.toJson(),
      'levelUpClicked': instance.levelUpClicked,
      'recustomizeOrderDetailsClicked': instance.recustomizeOrderDetailsClicked,
    };
