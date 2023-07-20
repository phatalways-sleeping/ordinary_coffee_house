import 'package:coffee_order_app/repositories/models/models.dart';
import 'package:coffee_order_app/states/home_view/home_view_bloc.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeProductView extends StatelessWidget {
  const CoffeeProductView({
    super.key,
    required this.product,
  });
  final CoffeeProduct product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<HomeViewBloc>(context).add(CustomDrinkEvent(product));
        BlocProvider.of<NavigationBloc>(context).add(const NavigateToDetails());
      },
      child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints.tightFor(height: 164, width: 154),
          decoration: ShapeDecoration(
            color: const Color(0xFFF7F8FB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(height: 100, width: 130),
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.name,
                style: const TextStyle(
                  color: Color(0xFF001833),
                  fontSize: 14,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )),
    );
  }
}
