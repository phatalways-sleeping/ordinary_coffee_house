part of 'home_view_bloc.dart';

abstract class HomeViewState extends Equatable {
  const HomeViewState({
    required this.username,
    required this.coffees,
    required this.totalDrinks,
    required this.clicked,
  });

  final String username;
  final List<CoffeeProduct> coffees;
  final int totalDrinks;
  final bool clicked;
  @override
  List<Object> get props => [
        username,
        coffees,
        totalDrinks,
        clicked,
      ];
}

class HomeViewFullState extends HomeViewState {
  const HomeViewFullState({
    required super.username,
    required super.coffees,
    required super.totalDrinks,
    required super.clicked,
  });
}
