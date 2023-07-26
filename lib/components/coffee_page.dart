import 'package:coffee_order_app/repositories/app_repository.dart';
import 'package:coffee_order_app/screens/screens.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  List<Page> onGeneratePages(
      BuildContext context, NavigationState state, List<Page> pages) {
    final applicationRepository =
        RepositoryProvider.of<ApplicationRepository>(context);
    return [
      if (state is HomePage)
        MaterialPage(
            child: BlocProvider(
          create: (context) => HomeViewBloc(applicationRepository),
          child: const HomePageView(key: PageStorageKey('HomePageView')),
        )),
      if (state is Details)
        MaterialPage(
            child: BlocProvider(
          create: (context) => OrderProcessingBloc(applicationRepository),
          child: const DetailsView(key: PageStorageKey('DetailsView')),
        )),
      if (state is MyCart)
        MaterialPage(
            child: BlocProvider(
          create: (context) => CartViewBloc(applicationRepository),
          child: const MyCartView(key: PageStorageKey('CartView')),
        )),
      if (state is OrderSuccess)
        const MaterialPage(
            child: OrderSuccessView(key: PageStorageKey('OrderSuccessView'))),
      if (state is Profile)
        MaterialPage(
            child: BlocProvider(
          create: (context) => ProfileViewBloc(applicationRepository),
          child: const ProfileView(key: PageStorageKey('ProfileView')),
        )),
      if (state is Rewards)
        MaterialPage(
            child: BlocProvider(
          create: (context) => RewardsBloc(applicationRepository),
          child: const RewardsView(key: PageStorageKey('RewardsView')),
        )),
      if (state is RedeeemRewards)
        MaterialPage(
            child: BlocProvider(
          create: (context) => RewardsBloc(applicationRepository),
          child:
              const RedeemRewardsView(key: PageStorageKey('RedeemRewardsView')),
        )),
      if (state is MyOrder)
        MaterialPage(
            child: BlocProvider(
          create: (context) => OrderViewBloc(applicationRepository),
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
