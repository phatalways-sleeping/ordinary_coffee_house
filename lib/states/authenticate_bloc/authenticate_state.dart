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