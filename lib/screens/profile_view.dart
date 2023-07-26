import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/screens/screens.dart';
import 'package:coffee_order_app/states/authenticate_bloc/authenticate_bloc.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        hideNavigationBar: true,
        appBar: OrdinaryHBar(
          forHomeView: false,
          title: 'Profile',
          allowBackNavigation: true,
          onBackNavigation: (context) =>
              BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateToHomePage()),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.custom(
            shrinkWrap: true,
            childrenDelegate: SliverChildListDelegate.fixed([
              ProfileInformation(
                  iconLeft: SvgAssets.profile_view_active_button,
                  title: 'Username',
                  initialValue: BlocProvider.of<ProfileViewBloc>(context)
                      .state
                      .currentUser
                      .username,
                  onComplete: (context, payload) =>
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(ChangeUsername(payload))),
              ProfileInformation(
                  iconLeft: SvgAssets.phone,
                  title: 'Phone number',
                  initialValue: BlocProvider.of<ProfileViewBloc>(context)
                      .state
                      .currentUser
                      .phone,
                  onComplete: (context, payload) =>
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(ChangePhoneNumber(payload))),
              ProfileInformation(
                  iconLeft: SvgAssets.email,
                  title: 'Email',
                  initialValue: BlocProvider.of<ProfileViewBloc>(context)
                      .state
                      .currentUser
                      .email,
                  onComplete: (context, payload) =>
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(ChangeEmail(payload))),
              ProfileInformation(
                  iconLeft: SvgAssets.address,
                  title: 'Address',
                  initialValue: BlocProvider.of<ProfileViewBloc>(context)
                      .state
                      .currentUser
                      .address,
                  onComplete: (context, payload) =>
                      BlocProvider.of<ProfileViewBloc>(context)
                          .add(ChangeAddress(payload))),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticateBloc>(context)
                        .add(const LogoutEvent());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 236, 133, 125).withOpacity(0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Sign out',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ))),
            ]),
          ),
        ));
  }
}
