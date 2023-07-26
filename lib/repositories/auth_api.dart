class AuthenticationAPI {
  AuthenticationAPI({
    this.email,
    this.password,
    this.address,
    this.phoneNumber,
    this.authStrategy = const EmailPasswordStrategy(),
  });

  String? email;
  String? password;
  String? address;
  String? phoneNumber;
  bool authenticated = false;
  AuthStrategy authStrategy;

  bool get isAuthenticated => authenticated;
  
  void changeEmail(String email) {
    this.email = email;
  }

  void changePassword(String password) {
    this.password = password;
  }

  void changeAddress(String address) {
    this.address = address;
  }

  void changePhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  void useEmailPasswordStrategy() {
    authStrategy = const EmailPasswordStrategy();
  }

  void useDefaultAccountLoginStrategy() {
    authStrategy = const DefaultAccountLoginStrategy();
  }

  Future<bool> login() async {
    assert(email != null && password != null);
    return authStrategy.login(email!, password!);
  }

  Future<bool> logout() async {
    return authStrategy.logout();
  }

  Future<bool> register() async {
    assert(
      email != null &&
          password != null &&
          address != null &&
          phoneNumber != null,
    );
    authStrategy = const RegisterAccountStrategy();
    return authStrategy.register(email!, password!, address!, phoneNumber!);
  }
}

abstract class AuthStrategy {
  Future<bool> login(
    String email,
    String password,
  );
  Future<bool> logout();
  Future<bool> register(
    String email,
    String password,
    String address,
    String phoneNumber,
  );
}

class EmailPasswordStrategy implements AuthStrategy {
  const EmailPasswordStrategy();

  @override
  Future<bool> login(String email, String password) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() async {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> register(
      String email, String password, String address, String phoneNumber) async {
    // TODO: implement register
    throw UnimplementedError();
  }
}

class DefaultAccountLoginStrategy implements AuthStrategy {
  const DefaultAccountLoginStrategy();

  @override
  Future<bool> login(String email, String password) async {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() async {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> register(
      String email, String password, String address, String phoneNumber) async {
    // TODO: implement register
    throw UnimplementedError();
  }
}

class RegisterAccountStrategy implements AuthStrategy {
  const RegisterAccountStrategy();

  @override
  Future<bool> login(String email, String password) async {
    throw UnimplementedError();
  }
  
  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
  
  @override
  Future<bool> register(String email, String password, String address, String phoneNumber) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
