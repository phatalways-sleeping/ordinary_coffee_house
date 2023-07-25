import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/firebase_options.dart';
import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/models/loyalty_membership.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/models/runtime_payload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance
      .collection('users')
      .doc(user.email).set(user.toJson());
  //     .set(user.toJson());
  // FirebaseFirestore.instance
  //     .collection('users')
  //     .doc('kimphat@gmail.com')
  //     .delete();

  // for (var element in coffeeProducts) {
  //   FirebaseFirestore.instance
  //       .collection('coffee_products')
  //       .doc(element.name)
  //       .set(element.toJson());
  // }

  // for (RewardBase element in [...currentRewards, ...currentVouchers]) {
  //   FirebaseFirestore.instance
  //       .collection('rewards')
  //       .doc(element.id)
  //       .set(RewardBase.toJson(element));
  // }

  // FirebaseFirestore.instance
  //     .collection('runtime_payloads')
  //     .doc(user.email)
  //     .set(RuntimePayload(orderCart: null, orderDetails: null).toJson());
  final data = await FirebaseFirestore.instance
      .collection('users')
      .doc('trankimphat@gmail.com')
      .get()
      .then((value) => value.data()!);
  debugPrint(data.toString());
  final userC = UserModel.fromJson(data);
  print(user == userC);
}
