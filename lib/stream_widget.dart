import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/models/coffee_product.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/models/runtime_payload.dart';
import 'package:coffee_order_app/models/user_model.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:coffee_order_app/screens/screens.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states/cart_view/cart_view_bloc.dart';
import 'states/home_view/home_view_bloc.dart';
import 'states/order_processing/order_processing_bloc.dart';
import 'states/order_view/order_view_bloc.dart';
import 'states/profile_view/profile_view_bloc.dart';
import 'states/rewards/rewards_bloc.dart';

class StreamWidget extends StatefulWidget {
  const StreamWidget({super.key, required this.email});
  final String email;

  @override
  State<StreamWidget> createState() => _StreamWidgetState();
}

class _StreamWidgetState extends State<StreamWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
                body: Center(
              child: Text('Something went wrong'),
            ));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Requesting user from Firebase Firestore...',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            ));
          } else {
            if (!snapshot.hasData) {
              return const Scaffold(
                  body: Center(
                child: Text(
                  'No data found',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ));
            } else if (snapshot.hasData) {
              final data = snapshot.data!.data()!;

              final user = UserModel.fromJson(data);

              return _StreamCoffeeProducts(user: user);
            }
          }

          return ErrorWidget('Something went wrong');
        });
  }
}

class _StreamCoffeeProducts extends StatefulWidget {
  const _StreamCoffeeProducts({super.key, required this.user});
  final UserModel user;
  @override
  State<_StreamCoffeeProducts> createState() => __StreamCoffeeProductsState();
}

class __StreamCoffeeProductsState extends State<_StreamCoffeeProducts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('coffee_products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(
            child: Text(
              'Something went wrong when trying to fetch coffee products from Firebase Firestore',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Requesting coffee products from Firebase Firestore...',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ));
        } else {
          if (snapshot.data == null) {
            return const Scaffold(
                body: Center(
              child: Text(
                'No data found',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ));
          }
          final data = snapshot.data!.docs.map((e) => e.data()).toList();
          final coffeeProducts =
              data.map((product) => CoffeeProduct.fromJson(product)).toList();

          return _StreamRewards(
            user: widget.user,
            coffeeProducts: coffeeProducts,
          );
        }
      },
    );
  }
}

class _StreamRewards extends StatefulWidget {
  const _StreamRewards(
      {super.key, required this.coffeeProducts, required this.user});
  final List<CoffeeProduct> coffeeProducts;
  final UserModel user;

  @override
  State<_StreamRewards> createState() => __StreamRewardsState();
}

class __StreamRewardsState extends State<_StreamRewards> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('rewards').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(
            child: Text(
              'Something went wrong when trying to fetch rewards from Firebase Firestore',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Requesting rewards from Firebase Firestore...',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ));
        } else {
          if (snapshot.data == null) {
            return const Scaffold(
                body: Center(
              child: Text(
                'No data found',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ));
          }
          final data = snapshot.data!.docs.map((e) => e.data()).toList();
          final rewards =
              data.map((reward) => RewardBase.fromJson(reward)).toList();
          return _StreamRuntimePayload(
            user: widget.user,
            coffeeProducts: widget.coffeeProducts,
            rewards: rewards,
          );
        }
      },
    );
  }
}

class _StreamRuntimePayload extends StatefulWidget {
  const _StreamRuntimePayload({
    super.key,
    required this.user,
    required this.coffeeProducts,
    required this.rewards,
  });
  final List<CoffeeProduct> coffeeProducts;
  final UserModel user;
  final List<RewardBase> rewards;
  @override
  State<_StreamRuntimePayload> createState() => __StreamRuntimePayloadState();
}

class __StreamRuntimePayloadState extends State<_StreamRuntimePayload> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('runtime_payloads')
          .doc(widget.user.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(
            child: Text(
              'Something went wrong when trying to fetch runtime payload from Firebase Firestore',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Requesting runtime payload from Firebase Firestore...',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ));
        } else {
          if (snapshot.data == null) {
            return const Scaffold(
                body: Center(
              child: Text(
                'No data found',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ));
          }
          final data = snapshot.data!.data()!;
          final runtimePayload = RuntimePayload.fromJson(data);
          return RepositoryProvider.value(
              value: ApplicationRepository(
                  user: widget.user,
                  rewards: widget.rewards,
                  products: widget.coffeeProducts,
                  runtimePayload: runtimePayload),
              child: const MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Ordinary Coffee House',
                  home: _Wrapee()));
        }
      },
    );
  }
}

class _Wrapee extends StatelessWidget {
  const _Wrapee({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NavigationBloc(context.read<ApplicationRepository>()),
      child: const _CoffeePage(),
    );
  }
}

class _CoffeePage extends StatelessWidget {
  const _CoffeePage({super.key});

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
