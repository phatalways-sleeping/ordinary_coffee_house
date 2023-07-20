import 'package:coffee_order_app/states/home_view/home_view_bloc.dart';
import 'package:coffee_order_app/states/order_processing/order_processing_bloc.dart';
import 'package:coffee_order_app/states/order_view/order_view_bloc.dart';
import 'package:coffee_order_app/states/profile_view/profile_view_bloc.dart';
import 'package:coffee_order_app/states/rewards/rewards_cubit.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/repositories.dart';
import 'screens/screens.dart';
import 'states/cart_view/cart_view_bloc.dart';
import 'states/navigation/navigation_bloc.dart';

void main() {
  runApp(RepositoryProvider(
    create: (context) => ApplicationRepository.instance,
    child: const CoffeeShopping(),
  ));
}

class CoffeeShopping extends StatelessWidget {
  const CoffeeShopping({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ordinary Coffee App',
        home: BlocProvider(
          create: (context) =>
              NavigationBloc(ApplicationRepository.instance),
          child: const CoffeePage(),
        ));
  }
}

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  List<Page> onGeneratePages(
      BuildContext context, NavigationState state, List<Page> pages) {
    final applicationRepository =
        RepositoryProvider.of<ApplicationRepository>(context);
    return [
      if (state is SplashScreen) const MaterialPage(child: SplashScreenView()),
      if (state is HomePage)
        MaterialPage(
            child: BlocProvider(
          create: (context) => HomeViewBloc(applicationRepository),
          child: const HomePageView(key: PageStorageKey('HomePageView')),
        )),
      if (state is Details)
        MaterialPage(
            child: BlocProvider(
          create: (context) =>
              OrderProcessingBloc(applicationRepository),
          child: const DetailsView(key: PageStorageKey('DetailsView')),
        )),
      if (state is MyCart)
        MaterialPage(
            child: BlocProvider(
          create: (context) =>
              CartViewBloc(applicationRepository),
          child: const MyCartView(key: PageStorageKey('CartView')),
        )),
      if (state is OrderSuccess)
        const MaterialPage(
            child: OrderSuccessView(key: PageStorageKey('OrderSuccessView'))),
      if (state is Profile)
        MaterialPage(
            child: BlocProvider(
          create: (context) =>
              ProfileViewBloc(applicationRepository),
          child: const ProfileView(key: PageStorageKey('ProfileView')),
        )),
      if (state is Rewards)
        MaterialPage(
            child: BlocProvider(
          create: (context) =>
              RewardsCubit(applicationRepository),
          child: const RewardsView(key: PageStorageKey('RewardsView')),
        )),
      if (state is RedeeemRewards)
        MaterialPage(
            child: BlocProvider(
          create: (context) =>
              RewardsCubit(applicationRepository),
          child:
              const RedeemRewardsView(key: PageStorageKey('RedeemRewardsView')),
        )),
      if (state is MyOrder)
        MaterialPage(
            child: BlocProvider(
          create: (context) =>
              OrderViewBloc(applicationRepository),
          child: const MyOrderView(key: PageStorageKey('MyOrderView')),
        )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
      onGeneratePages: (NavigationState state, List<Page> pages) =>
          onGeneratePages(context, state, pages),
      state: context.watch<NavigationBloc>().state,
    );
  }
}
