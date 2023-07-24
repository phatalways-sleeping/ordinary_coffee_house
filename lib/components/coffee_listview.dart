import 'package:coffee_order_app/components/coffee_productview.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:flutter/material.dart';

class CoffeeListView extends StatelessWidget {
  const CoffeeListView({super.key, required this.coffees});

  final List<CoffeeProduct> coffees;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 100),
        decoration: const ShapeDecoration(
          color: Color(0xFF324A59),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 31, top: 24),
              child: Text(
                'Choose your coffee',
                style: TextStyle(
                  color: Color(0xFFD7D7D7),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GridView.count(
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  for (final coffee in coffees)
                    CoffeeProductView(product: coffee)
                ],
              ),
            )
          ],
        ));
  }
}
