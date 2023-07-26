import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/repositories/auth_repository.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:equatable/equatable.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  AuthenticateBloc(this._authenticateRepository) : super(const SplashScreen()) {
    on<AuthenticateEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<NavigateToLoginScreen>((event, emit) {
      emit(const EmailPasswordAuthenticationState());
    });

    on<NavigateToRegisterScreen>((event, emit) {
      emit(const RegisterState());
    });

  }

  final AuthRepository _authenticateRepository;
}
