import 'package:coffee_order_app/repositories/models/models.dart';
import 'package:coffee_order_app/states/home_view/home_view_bloc.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeProductView extends StatelessWidget {
  const CoffeeProductView({
    super.key,
    required this.product,
    this.inCarousel = false,
  });
  final CoffeeProduct product;
  final bool inCarousel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (inCarousel) {
          BlocProvider.of<HomeViewBloc>(context)
              .add(CustomFreeDrinkEvent(product));
        } else {
          BlocProvider.of<HomeViewBloc>(context).add(CustomDrinkEvent(product));
        }

        BlocProvider.of<NavigationBloc>(context).add(const NavigateToDetails());
      },
      child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints.tightFor(height: 164, width: 154),
          decoration: ShapeDecoration(
            color:
                !inCarousel ? const Color(0xFFF7F8FB) : const Color(0xFF324A59),
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
                style: TextStyle(
                  color: !inCarousel
                      ? const Color(0xFF001833)
                      : const Color(0xFFF7F8FB),
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
