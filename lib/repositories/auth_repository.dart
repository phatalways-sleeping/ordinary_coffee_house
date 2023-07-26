import 'package:coffee_order_app/repositories/auth_api.dart';

class AuthRepository {
  AuthRepository() : _authenticationAPI = AuthenticationAPI();
  final AuthenticationAPI _authenticationAPI;

  String get email => _authenticationAPI.email!;

  Stream<bool> get isAuthenticated => _authenticationAPI.isAuthenticatedStream;

  Future<bool> login() {
    return _authenticationAPI.login();
  }

  Future<bool> register() {
    return _authenticationAPI.register();
  }

  Future<bool> logout() {
    return _authenticationAPI.logout();
  }

  void changeEmail(String email) {
    _authenticationAPI.changeEmail(email);
  }

  void changePassword(String password) {
    _authenticationAPI.changePassword(password);
  }

  void changeAddress(String address) {
    _authenticationAPI.changeAddress(address);
  }

  void changePhoneNumber(String phoneNumber) {
    _authenticationAPI.changePhoneNumber(phoneNumber);
  }

  void changeUsername(String username) {
    _authenticationAPI.changeUsername(username);
  }

  void useAnynomousAccount() {
    _authenticationAPI.useDefaultAccountLoginStrategy();
  }
}
