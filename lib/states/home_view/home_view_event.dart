part of 'home_view_bloc.dart';

abstract class HomeViewEvent extends Equatable {
  const HomeViewEvent();

  @override
  List<Object> get props => [];
}


class CustomDrinkEvent extends HomeViewEvent {
  const CustomDrinkEvent(this.coffeeProduct);

  final CoffeeProduct coffeeProduct;

  @override
  List<Object> get props => [coffeeProduct];
}

class LevelUpEvent extends HomeViewEvent {
  const LevelUpEvent();
}