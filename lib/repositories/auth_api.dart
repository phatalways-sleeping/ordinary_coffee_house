import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationAPI {
  AuthenticationAPI({
    this.email,
    this.password,
    this.address,
    this.phoneNumber,
    this.username,
    this.authStrategy = const EmailPasswordStrategy(),
  });

  String? email;
  String? password;
  String? address;
  String? phoneNumber;
  String? username;
  bool authenticated = false;
  AuthStrategy authStrategy;

  Stream<bool> get isAuthenticatedStream async* {
    yield await FirebaseAuth.instance.authStateChanges().map((user) {
      return user != null;
    }).first;
  }

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

  void changeUsername(String username) {
    this.username = username;
  }

  void useEmailPasswordStrategy() {
    authStrategy = const EmailPasswordStrategy();
  }

  void useDefaultAccountLoginStrategy() {
    authStrategy = const DefaultAccountLoginStrategy();
    changeEmail('trankimphat@gmail.com');
    changePassword('trankimphat');
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
          phoneNumber != null &&
          username != null,
    );
    authStrategy = const RegisterAccountStrategy();
    return authStrategy.register(
        email!, password!, address!, phoneNumber!, username!);
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
    String username,
  );
}

class EmailPasswordStrategy implements AuthStrategy {
  const EmailPasswordStrategy();

  @override
  Future<bool> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user != null;
    } on FirebaseAuthException {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  @override
  Future<bool> register(String email, String password, String address,
      String phoneNumber, String username) async {
    throw UnimplementedError();
  }
}

class DefaultAccountLoginStrategy implements AuthStrategy {
  const DefaultAccountLoginStrategy();

  @override
  Future<bool> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user != null;
    } on FirebaseAuthException {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  @override
  Future<bool> register(String email, String password, String address,
      String phoneNumber, String username) async {
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
  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  @override
  Future<bool> register(String email, String password, String address,
      String phoneNumber, String username) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      debugPrint(credential.user.toString());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .set(UserModel(
            username: username,
            email: email,
            address: address,
            phone: phoneNumber,
            historyOrders: const [],
            onGoingOrders: const [],
            totalPoints: 0,
          ).toJson());

      await FirebaseFirestore.instance
          .collection('runtime_payloads')
          .doc(email)
          .set(RuntimePayload(
            orderCart: null,
            orderDetails: null,
            levelUpClicked: false,
          ).toJson());
      return credential.user != null;
    } on FirebaseAuthException {
      return false;
    }
  }
}
