part of 'home_view_bloc.dart';

abstract class HomeViewState extends Equatable {
  const HomeViewState({
    required this.username,
    required this.coffees,
    required this.totalDrinks,
    required this.clicked,
    required this.drinkRewards,
  });

  final String username;
  final List<CoffeeProduct> coffees;
  final List<DrinkReward> drinkRewards;
  final int totalDrinks;
  final bool clicked;
  @override
  List<Object> get props => [
        username,
        coffees,
        totalDrinks,
        clicked,
        drinkRewards,
      ];
}

class HomeViewFullState extends HomeViewState {
  const HomeViewFullState({
    required super.username,
    required super.coffees,
    required super.totalDrinks,
    required super.clicked,
    required super.drinkRewards,
  });
}
