import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/components/order_details_item.dart';
import 'package:coffee_order_app/components/result_bottom_bar.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/cart_view/cart_view_bloc.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watch<CartViewBloc>().state.orderCart == null) {
      return BaseScreen(
          hideAppBar: false,
          hideNavigationBar: true,
          appBar: OrdinaryHBar(
            forHomeView: false,
            allowBackNavigation: true,
            onBackNavigation: (context) =>
                BlocProvider.of<NavigationBloc>(context)
                    .add(const NavigateBackFromCartView()),
          ),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'My Cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF001833),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(
                            color: Color(0xFF001833),
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ])));
    }
    return BaseScreen(
        hideAppBar: false,
        hideNavigationBar:
            context.watch<CartViewBloc>().state.orderCart!.items.isEmpty,
        customBottomBar:
            context.watch<CartViewBloc>().state.orderCart!.items.isNotEmpty,
        customNavigationBar: ResultsBottomBar(
          forDetails: false,
          checkOut: (context) {
            BlocProvider.of<CartViewBloc>(context).add(const CheckOut());
            BlocProvider.of<NavigationBloc>(context)
                .add(const NavigateToOrderSuccess());
          },
          price: context.watch<CartViewBloc>().state.orderCart!.totalPrice(),
        ),
        appBar: OrdinaryHBar(
          forHomeView: false,
          allowBackNavigation: true,
          onBackNavigation: (context) =>
              BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateBackFromCartView()),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'My Cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF001833),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              if (context
                  .watch<CartViewBloc>()
                  .state
                  .orderCart!
                  .items
                  .isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: context
                        .watch<CartViewBloc>()
                        .state
                        .orderCart!
                        .items
                        .length,
                    itemBuilder: (context, index) {
                      return OrderDetailsItem(
                        orderDetails: context
                            .watch<CartViewBloc>()
                            .state
                            .orderCart!
                            .items[index],
                      );
                    },
                  ),
                )
              else
                const Expanded(
                  child: Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(
                        color: Color(0xFF001833),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
