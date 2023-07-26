part of 'authenticate_bloc.dart';

abstract class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();

  @override
  List<Object> get props => [];
}


class NavigateToLoginScreen extends AuthenticateEvent {
  const NavigateToLoginScreen();
}

class NavigateToRegisterScreen extends AuthenticateEvent {
  const NavigateToRegisterScreen();
}