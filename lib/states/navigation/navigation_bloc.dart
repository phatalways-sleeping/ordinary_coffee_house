// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc(this._applicationRepository) : super(const SplashScreen()) {
    on<NavigateBackFromCartView>(((event, emit) {
      if (_applicationRepository.orderDetails == null) {
        emit(const HomePage());
      } else {
        emit(const Details());
      }
    }));
    on<NavigateBackFromDetailsView>((event, emit) async  {
      if(_applicationRepository.recustomizeOrderDetailsClicked) {
        await _applicationRepository.unCheckRecustomizeOrderDetails();
        emit(const MyCart());
        return;
      }
      await _applicationRepository.clearOrderDetails();
      emit(const HomePage());
    });
    on<NavigateToSplashScreen>((event, emit) => emit(const SplashScreen()));
    on<NavigateToHomePage>((event, emit) => emit(const HomePage()));
    on<NavigateToDetails>((event, emit) => emit(const Details()));
    on<NavigateToMyCart>((event, emit) => emit(const MyCart()));
    on<NavigateToOrderSuccess>((event, emit) => emit(const OrderSuccess()));
    on<NavigateToProfile>((event, emit) => emit(const Profile()));
    on<NavigateToRewards>((event, emit) => emit(const Rewards()));
    on<NavigateToRedeeemRewards>((event, emit) => emit(const RedeeemRewards()));
    on<NavigateToMyOrder>((event, emit) => emit(const MyOrder()));
  }

  final ApplicationRepository _applicationRepository;
}
