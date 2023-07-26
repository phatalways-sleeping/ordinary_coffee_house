import 'package:coffee_order_app/components/custom_textfield.dart';
import 'package:coffee_order_app/states/authenticate_bloc/authenticate_bloc.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(
          'assets/splash_screen.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0x5E1D2335).withOpacity(0.4),
        ),
        SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Form(
                      child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 90),
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      controller: _emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      controller: _passwordController,
                      hintText: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    if (context.watch<AuthenticateBloc>().state
                        is LoginFailureState) ...[
                      Text(
                        (context.watch<AuthenticateBloc>().state
                                as LoginFailureState)
                            .message,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthenticateBloc>(context).add(
                              LoginEvent(_emailController.text,
                                  _passwordController.text));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 25, 94, 27),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          minimumSize: const Size(double.infinity, 36),
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    const SizedBox(height: 20),
                    if (context.watch<AuthenticateBloc>().state
                        is LoginLoadingState) ...[
                      const CircularProgressIndicator(
                        color: Colors.green,
                      ),
                      const SizedBox(height: 20)
                    ],
                    const Center(
                      child: Text(
                        'Or you can use anynomous account to sign in',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthenticateBloc>(context)
                              .add(const AnynomousLoginEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          backgroundColor:
                              const Color.fromARGB(255, 25, 94, 27),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(100, 36),
                        ),
                        child: const Text(
                          'Use anynomous account',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Or create an new account here',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthenticateBloc>(context)
                              .add(const NavigateToRegisterScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          backgroundColor:
                              const Color.fromARGB(255, 25, 94, 27),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(300, 36),
                        ),
                        child: const Text(
                          'Create an account',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
              )))
            ],
          ),
        )
      ],
    );
  }
}
