import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/repositories/auth_repository.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:equatable/equatable.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  AuthenticateBloc(this._authenticateRepository) : super(const SplashScreen()) {
    on<NavigateToLoginScreen>((event, emit) {
      emit(const EmailPasswordAuthenticationState());
    });

    on<NavigateToRegisterScreen>((event, emit) {
      emit(const RegisterState());
    });

    on<AnynomousLoginEvent>((event, emit) async {
      _authenticateRepository.useAnynomousAccount();
      emit(const LoginLoadingState());
      await _authenticateRepository.login();
      emit(const SuccessState());
    });

    on<LoginEvent>((event, emit) async {
      _authenticateRepository.changeEmail(event.email);
      _authenticateRepository.changePassword(event.password);
      emit(const LoginLoadingState());
      final isAuthenticated = await _authenticateRepository.login();
      if (isAuthenticated) {
        emit(const SuccessState());
      } else {
        emit(const LoginFailureState('Either email or password is incorrect'));
      }
    });

    on<RegisterEvent>((event, emit) async {
      _authenticateRepository.changeEmail(event.email);
      _authenticateRepository.changePassword(event.password);
      _authenticateRepository.changePhoneNumber(event.phoneNumber);
      _authenticateRepository.changeAddress(event.address);
      _authenticateRepository.changeUsername(event.username);
      emit(const RegisterLoadingState());
      final isAuthenticated = await _authenticateRepository.register();

      if (isAuthenticated) {
        emit(const SuccessState());
      } else {
        emit(const RegisterFailureState(
            'Either email or password is incorrect'));
      }
    });

    on<SuccessEvent>((event, emit) {
      emit(const SuccessState());
    });

    on<LogoutEvent>((event, emit) async {
      await _authenticateRepository.logout();
      emit(const SplashScreen());
    });
  }

  final AuthRepository _authenticateRepository;
}
