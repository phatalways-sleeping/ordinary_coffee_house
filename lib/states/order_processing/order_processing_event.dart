part of 'order_processing_bloc.dart';

abstract class OrderProcessingEvent extends Equatable {
  const OrderProcessingEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends OrderProcessingEvent {
  const AddToCart();
}

class ChangeAmount extends OrderProcessingEvent {
  const ChangeAmount(this.amount);

  final int amount;

  @override
  List<Object> get props => [amount];
}

class ChangeShot extends OrderProcessingEvent {
  const ChangeShot(this.shot);

  final DrinkShot shot;

  @override
  List<Object> get props => [shot];
}

class ChangeSize extends OrderProcessingEvent {
  const ChangeSize(this.size);

  final DrinkSize size;

  @override
  List<Object> get props => [size];
}

class ChangeSelect extends OrderProcessingEvent {
  const ChangeSelect(this.type);

  final DrinkType type;

  @override
  List<Object> get props => [type];
}

class ChangeIce extends OrderProcessingEvent {
  const ChangeIce(this.ice);

  final IceLevel ice;

  @override
  List<Object> get props => [ice];
}
