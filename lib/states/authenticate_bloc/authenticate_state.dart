part of 'authenticate_bloc.dart';

abstract class AuthenticateState extends Equatable {
  const AuthenticateState();
  
  @override
  List<Object> get props => [];
}

class SplashScreen extends AuthenticateState {
  const SplashScreen();
}


class EmailPasswordAuthenticationState extends AuthenticateState {
  const EmailPasswordAuthenticationState();
}

class RegisterState extends AuthenticateState {
  const RegisterState();
}

class SuccessState extends AuthenticateState {
  const SuccessState();
}

class LoginLoadingState extends AuthenticateState {
  const LoginLoadingState();
}

class RegisterLoadingState extends AuthenticateState {
  const RegisterLoadingState();
}

class LoginFailureState extends AuthenticateState {
  const LoginFailureState(this.message);
  final String message;

  @override
  List<Object> get props => [...super.props, message];
}

class RegisterFailureState extends AuthenticateState {
  const RegisterFailureState(this.message);
  final String message;

  @override
  List<Object> get props => [...super.props, message];
}