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

class AnynomousLoginEvent extends AuthenticateEvent {
  const AnynomousLoginEvent();
}

class LoginEvent extends AuthenticateEvent {
  const LoginEvent(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object> get props => [...super.props, email, password];
}

class RegisterEvent extends AuthenticateEvent {
  const RegisterEvent(
    this.email,
    this.password,
    this.confirmPassword,
    this.phoneNumber,
    this.username,
    this.address,
  );
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String username;
  final String address;

  @override
  List<Object> get props => [
        ...super.props,
        email,
        password,
        confirmPassword,
        phoneNumber,
        username,
        address
      ];
}

class SuccessEvent extends AuthenticateEvent {
  const SuccessEvent();
}

class LogoutEvent extends AuthenticateEvent {
  const LogoutEvent();
}
