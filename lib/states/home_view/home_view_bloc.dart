// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/repositories/models/models.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  HomeViewBloc(this._applicationRepository)
      : super(HomeViewFullState(
          username: _applicationRepository.currentUser.username,
          coffees: _applicationRepository.products,
          totalDrinks: _applicationRepository.currentUser.totalDrinks,
          clicked: _applicationRepository.clicked,
        )) {
    on<CustomDrinkEvent>(
      (event, emit) {
        _applicationRepository.customizeOrderDetails(event.coffeeProduct);
      },
    );

    on<LevelUpEvent>((event, emit) {
      _applicationRepository.levelUp();
      emit(
        HomeViewFullState(
          username: _applicationRepository.currentUser.username,
          coffees: _applicationRepository.products,
          totalDrinks: _applicationRepository.currentUser.totalDrinks,
          clicked: _applicationRepository.clicked,
        ),
      );
    });
  }

  final ApplicationRepository _applicationRepository;
}
