import 'package:coffee_order_app/stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CoffeeShopping());
}

class CoffeeShopping extends StatelessWidget {
  const CoffeeShopping({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Shopping',
      home: StreamWidget(email: 'trankimphat@gmail.com',),
    );
  }
}




