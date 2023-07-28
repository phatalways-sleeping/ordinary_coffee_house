import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flutter/material.dart';

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
          price: context.watch<CartViewBloc>().totalPrice,
        ),
        appBar: OrdinaryHBar(
          forHomeView: false,
          allowBackNavigation: true,
          onBackNavigation: (context) =>
              BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateBackFromCartView()),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: context
                          .watch<CartViewBloc>()
                          .state
                          .orderCart!
                          .items
                          .isNotEmpty
                      ? [
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          const Text(
                            'My Cart',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(0xFF001833),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          ListView.builder(
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
                          ...sliverLines,
                          BlocSelector<CartViewBloc, CartViewState,
                              DiscountVoucher?>(
                            selector: (state) => state.bestDiscountOption,
                            builder: (context, state) {
                              return _BestOptionDisplay(
                                  title: 'Best Discount Option Applied',
                                  result:
                                      'There is no discount voucher available',
                                  state: state);
                            },
                          ),
                          ...sliverLines,
                          BlocSelector<CartViewBloc, CartViewState,
                              FreeshipVoucher?>(
                            selector: (state) => state.bestFreeshipOption,
                            builder: (context, state) {
                              return _BestOptionDisplay(
                                  title: 'Freeshipping Applied',
                                  result:
                                      'There is no freeship voucher available',
                                  state: state);
                            },
                          ),
                          ...sliverLines,
                          BlocBuilder<CartViewBloc, CartViewState>(
                            buildWhen: (previous, current) =>
                                previous.discountPrice !=
                                    current.discountPrice ||
                                previous.freeShipPrice != current.freeShipPrice,
                            builder: (context, state) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Shipping Fee:',
                                        style: TextStyle(
                                          color: Color(0xFF324A59),
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '+ \$${state.freeShipPrice.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Discount:',
                                        style: TextStyle(
                                          color: Color(0xFF324A59),
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '-\$${state.discountPrice.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          const Padding(padding: EdgeInsets.only(top: 100)),
                        ]
                      : [
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          const Text(
                            'My Cart',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(0xFF001833),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          const Center(
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
                        ],
                ),
              ),
            )
          ],
        ));
  }
}

const sliverLines = [
  Padding(
      padding: EdgeInsets.only(top: 10),
      child: Divider(
        color: Color(0xFF324A59),
        thickness: 4,
        height: 1,
      )),
  Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Divider(color: Color(0xFF324A59), thickness: 1, height: 1)),
];

class _BestOptionDisplay extends StatelessWidget {
  const _BestOptionDisplay({
    super.key,
    this.state,
    required this.title,
    required this.result,
  });

  final String title;

  final String result;

  final Voucher? state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Color(0xFF001833),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (state != null)
              const Icon(Icons.check_circle,
                  color: Color.fromARGB(255, 61, 143, 63), size: 25)
            else
              const Icon(Icons.cancel,
                  color: Color.fromARGB(255, 255, 0, 0), size: 25)
          ],
        ),
        if (state != null)
          RedeemDetail(reward: state!, masked: true)
        else
          Text(
            result,
            style: const TextStyle(
              color: Color(0xFF324A59),
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          )
      ],
    );
  }
}
