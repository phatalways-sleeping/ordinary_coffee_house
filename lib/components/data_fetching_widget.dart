import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/components/coffee_page.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/repositories/auth_repository.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flutter/material.dart';

class DataFetchingWidget extends StatefulWidget {
  const DataFetchingWidget({super.key});

  @override
  State<DataFetchingWidget> createState() => _DataFetchingWidgetState();
}

class _DataFetchingWidgetState extends State<DataFetchingWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(
            child: Text(
              'Something went wrong when trying to fetch data from Firebase Firestore',
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
                  'Requesting data from Firebase Firestore...',
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
          final productsJson =
              (snapshot.data![0] as QuerySnapshot<Map<String, dynamic>>?)!
                  .docs
                  .map((e) => e.data())
                  .toList();
          final rewardsJson =
              (snapshot.data![1] as QuerySnapshot<Map<String, dynamic>>?)!
                  .docs
                  .map((e) => e.data())
                  .toList();
          final userJson =
              (snapshot.data![2] as DocumentSnapshot<Map<String, dynamic>>?)!
                  .data()!;
          final runtimePayloadJson =
              (snapshot.data![3] as DocumentSnapshot<Map<String, dynamic>>?)!
                  .data()!;
          final products = productsJson
              .map((product) => CoffeeProduct.fromJson(product))
              .toList();
          final rewards =
              rewardsJson.map((reward) => RewardBase.fromJson(reward)).toList();
          final user = UserModel.fromJson(userJson);
          final runtimePayload = RuntimePayload.fromJson(runtimePayloadJson);
          final applicationRepository = ApplicationRepository(
              user: user,
              rewards: rewards,
              products: products,
              runtimePayload: runtimePayload);
          return RepositoryProvider.value(
              value: applicationRepository,
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Ordinary Coffee House',
                  home: BlocProvider(
                    create: (context) => NavigationBloc(applicationRepository),
                    child: const CoffeePage(),
                  )));
        }
      },
      future: Future.wait([
        FirebaseFirestore.instance.collection('coffee_products').get(),
        FirebaseFirestore.instance.collection('rewards').get(),
        FirebaseFirestore.instance
            .collection('users')
            .doc(context.read<AuthRepository>().email)
            .get(),
        FirebaseFirestore.instance
            .collection('runtime_payloads')
            .doc(context.read<AuthRepository>().email)
            .get(),
      ]),
    );
  }
}