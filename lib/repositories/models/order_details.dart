import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'coffee_product.dart';

class OrderDetails extends Equatable {
  const OrderDetails({
    required this.id,
    required this.amount,
    required this.product,
    required this.orderedAt,
    this.shot = DrinkShot.single,
    this.drinkType = DrinkType.cold,
    this.drinkSize = DrinkSize.medium,
    this.iceLevel = IceLevel.normal,
  });

  OrderDetails.deflt({
    required CoffeeProduct product,
  }) : this(
            amount: 1,
            id: const Uuid().v4(),
            product: product,
            orderedAt: ConstDateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              DateTime.now().hour,
              DateTime.now().minute,
            ));

  final String id;
  final int amount;
  final CoffeeProduct product;
  final DrinkShot shot;
  final DrinkType drinkType;
  final DrinkSize drinkSize;
  final IceLevel iceLevel;
  final ConstDateTime orderedAt;

  static const double _singleShotPrice = 0;
  static const double _doubleShotPrice = 2.0;

  static const double _smallPrice = 0.75;
  static const double _mediumPrice = 1.0;
  static const double _largePrice = 1.25;

  static const double _hotDrink = 0.75;
  static const double _icedDrink = 1.0;

  double get price {
    double price = 0;
    price += product.price * amount;
    price *= drinkSize == DrinkSize.small
        ? _smallPrice
        : drinkSize == DrinkSize.medium
            ? _mediumPrice
            : _largePrice;
    price *= drinkType == DrinkType.hot ? _hotDrink : _icedDrink;
    price += shot == DrinkShot.single ? _singleShotPrice : _doubleShotPrice;
    return price;
  }

  String get description {
    final drinkTypeString = drinkType == DrinkType.hot ? 'hot' : 'iced';
    final drinkSizeString = drinkSize == DrinkSize.small
        ? 'small'
        : drinkSize == DrinkSize.medium
            ? 'medium'
            : 'large';
    final iceLevelString = iceLevel == IceLevel.less
        ? 'less ice'
        : iceLevel == IceLevel.normal
            ? 'normal ice'
            : 'full ice';
    final shotString = shot == DrinkShot.single ? 'single' : 'double';
    return [shotString, drinkTypeString, drinkSizeString, iceLevelString]
        .join(' | ');
  }

  OrderDetails copyWith({
    String? id,
    int? amount,
    CoffeeProduct? product,
    DrinkShot? shot,
    DrinkType? drinkType,
    DrinkSize? drinkSize,
    IceLevel? iceLevel,
    ConstDateTime? orderedAt,
  }) =>
      OrderDetails(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        product: product ?? this.product,
        shot: shot ?? this.shot,
        drinkType: drinkType ?? this.drinkType,
        drinkSize: drinkSize ?? this.drinkSize,
        iceLevel: iceLevel ?? this.iceLevel,
        orderedAt: orderedAt ?? this.orderedAt,
      );

  @override
  List<Object?> get props => [
        id,
        amount,
        product,
        shot,
        drinkType,
        drinkSize,
        iceLevel,
        orderedAt,
      ];
}

enum DrinkSize {
  small,
  medium,
  large,
}

enum IceLevel {
  less,
  normal,
  more,
}

enum DrinkType {
  hot,
  cold,
}

enum DrinkShot {
  single,
  double,
}
