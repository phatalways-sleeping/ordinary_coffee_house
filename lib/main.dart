import 'package:coffee_order_app/components/authentication_flow.dart';
import 'package:coffee_order_app/repositories/auth_repository.dart';
import 'package:coffee_order_app/states/authenticate_bloc/authenticate_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'states/state_management.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(CoffeeShoppingApp());
}

class CoffeeShoppingApp extends StatelessWidget {
  CoffeeShoppingApp({super.key,});
  final AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shopping',
      home: RepositoryProvider.value(
       value: _authRepository,
        child: BlocProvider(
          create: (context) => AuthenticateBloc(_authRepository),
          child: const AuthenticationFlow(),
        ),
      ),
    );
  }
}
