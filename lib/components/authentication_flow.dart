import 'package:coffee_order_app/components/data_fetching_widget.dart';
import 'package:coffee_order_app/screens/login_screen.dart';
import 'package:coffee_order_app/screens/register_screen.dart';
import 'package:coffee_order_app/screens/splash_screen_view.dart';
import 'package:coffee_order_app/states/authenticate_bloc/authenticate_bloc.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

class AuthenticationFlow extends StatelessWidget {
  const AuthenticationFlow({super.key});

  List<Page<dynamic>> onGeneratePages(
      AuthenticateState state, List<Page> pages) {
    return [
      if (state is SplashScreen) const MaterialPage(child: SplashScreenView()),
      if (state is EmailPasswordAuthenticationState ||
          state is LoginFailureState ||
          state is LoginLoadingState)
        const MaterialPage(
            child: LoginScreen(key: PageStorageKey('LoginView'))),
      if (state is RegisterState ||
          state is RegisterFailureState ||
          state is RegisterLoadingState)
        const MaterialPage(
            child: RegisterScreen(key: PageStorageKey('RegisterView'))),
      if (state is SuccessState) const MaterialPage(child: DataFetchingWidget())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
      onGeneratePages: onGeneratePages,
      state: context.watch<AuthenticateBloc>().state,
    );
  }
}
