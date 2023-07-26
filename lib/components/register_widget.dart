import 'package:coffee_order_app/components/custom_textfield.dart';
import 'package:coffee_order_app/states/authenticate_bloc/authenticate_bloc.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _confirmPasswordController =
      TextEditingController();
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _phoneNumberController =
      TextEditingController();
  late final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
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
        Form(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: BackButton(
                          color: Colors.white,
                          onPressed: () {
                            BlocProvider.of<AuthenticateBloc>(context)
                                .add(const NavigateToLoginScreen());
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Register',
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
                    CustomInputField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      controller: _usernameController,
                      hintText: 'Username',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      controller: _phoneNumberController,
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      controller: _addressController,
                      hintText: 'Address',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    if (context.watch<AuthenticateBloc>().state
                        is RegisterLoadingState) ...[
                      const CircularProgressIndicator(
                        color: Colors.green,
                      ),
                      const SizedBox(height: 20)
                    ],
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthenticateBloc>(context)
                              .add(RegisterEvent(
                            _emailController.text,
                            _passwordController.text,
                            _phoneNumberController.text,
                            _usernameController.text,
                            _addressController.text,
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 25, 94, 27),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          minimumSize: const Size(300, 48),
                        ),
                        child: const Text(
                          'Create new account',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    const SizedBox(height: 20),
                    if (context.watch<AuthenticateBloc>().state
                        is RegisterFailureState) ...[
                      Text(
                        (context.read<AuthenticateBloc>().state
                                as RegisterFailureState)
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
                  ],
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
