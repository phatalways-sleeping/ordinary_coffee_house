import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:coffee_order_app/screens/screens.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

class FutureWidget extends StatefulWidget {
  const FutureWidget({super.key, required this.email});
  final String email;

  @override
  State<FutureWidget> createState() => _FutureWidgetState();
}

class _FutureWidgetState extends State<FutureWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.email)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
                body: Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Requesting user from Firebase Firestore...',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(
                    color: Colors.green,
                  ),
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

              return _FutureCoffeeProducts(user: user);
            }
          }

          return ErrorWidget('Something went wrong');
        });
  }
}

class _FutureCoffeeProducts extends StatefulWidget {
  const _FutureCoffeeProducts({super.key, required this.user});
  final UserModel user;
  @override
  State<_FutureCoffeeProducts> createState() => __FutureCoffeeProductsState();
}

class __FutureCoffeeProductsState extends State<_FutureCoffeeProducts> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('coffee_products').get(),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Requesting coffee products from Firebase Firestore...',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  color: Colors.green,
                ),
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

          return _FutureRewards(
            user: widget.user,
            coffeeProducts: coffeeProducts,
          );
        }
      },
    );
  }
}

class _FutureRewards extends StatefulWidget {
  const _FutureRewards(
      {super.key, required this.coffeeProducts, required this.user});
  final List<CoffeeProduct> coffeeProducts;
  final UserModel user;

  @override
  State<_FutureRewards> createState() => __FutureRewardsState();
}

class __FutureRewardsState extends State<_FutureRewards> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('rewards').get(),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Requesting rewards from Firebase Firestore...',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  color: Colors.green,
                ),
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
          return _FutureRuntimePayload(
            user: widget.user,
            coffeeProducts: widget.coffeeProducts,
            rewards: rewards,
          );
        }
      },
    );
  }
}

class _FutureRuntimePayload extends StatefulWidget {
  const _FutureRuntimePayload({
    super.key,
    required this.user,
    required this.coffeeProducts,
    required this.rewards,
  });
  final List<CoffeeProduct> coffeeProducts;
  final UserModel user;
  final List<RewardBase> rewards;
  @override
  State<_FutureRuntimePayload> createState() => __FutureRuntimePayloadState();
}

class __FutureRuntimePayloadState extends State<_FutureRuntimePayload> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('runtime_payloads')
          .doc(widget.user.email)
          .get(),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Requesting runtime payload from Firebase Firestore...',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  color: Colors.green,
                ),
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
  const _Wrapee();

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
  const _CoffeePage();

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
