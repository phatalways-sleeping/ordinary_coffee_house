import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/components/profile_information.dart';
import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:coffee_order_app/states/profile_view/profile_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            ]),
          ),
        ));
  }
}
