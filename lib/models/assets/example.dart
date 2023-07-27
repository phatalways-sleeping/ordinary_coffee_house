import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_order_app/firebase_options.dart';
import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  for(final reward in [...currentRewards, ...currentVouchers]) {
    FirebaseFirestore.instance.collection('rewards').doc(reward.id).set(RewardBase.toJson(reward));
  }
}
