// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BronzeMembership _$BronzeMembershipFromJson(Map<String, dynamic> json) =>
    BronzeMembership(
      currentDrinks: json['currentDrinks'] as int? ?? 0,
      maximumDrinks: json['maximumDrinks'] as int? ?? 8,
    );

Map<String, dynamic> _$BronzeMembershipToJson(BronzeMembership instance) =>
    <String, dynamic>{
      'currentDrinks': instance.currentDrinks,
      'maximumDrinks': instance.maximumDrinks,
    };

SilverMembership _$SilverMembershipFromJson(Map<String, dynamic> json) =>
    SilverMembership(
      currentDrinks: json['currentDrinks'] as int? ?? 0,
      maximumDrinks: json['maximumDrinks'] as int? ?? 15,
    );

Map<String, dynamic> _$SilverMembershipToJson(SilverMembership instance) =>
    <String, dynamic>{
      'currentDrinks': instance.currentDrinks,
      'maximumDrinks': instance.maximumDrinks,
    };

GoldMembership _$GoldMembershipFromJson(Map<String, dynamic> json) =>
    GoldMembership(
      currentDrinks: json['currentDrinks'] as int? ?? 0,
      maximumDrinks: json['maximumDrinks'] as int? ?? 30,
    );

Map<String, dynamic> _$GoldMembershipToJson(GoldMembership instance) =>
    <String, dynamic>{
      'currentDrinks': instance.currentDrinks,
      'maximumDrinks': instance.maximumDrinks,
    };

PremiumMembership _$PremiumMembershipFromJson(Map<String, dynamic> json) =>
    PremiumMembership(
      currentDrinks: json['currentDrinks'] as int? ?? 0,
      maximumDrinks: json['maximumDrinks'] as int? ?? 50,
    );

Map<String, dynamic> _$PremiumMembershipToJson(PremiumMembership instance) =>
    <String, dynamic>{
      'currentDrinks': instance.currentDrinks,
      'maximumDrinks': instance.maximumDrinks,
    };
