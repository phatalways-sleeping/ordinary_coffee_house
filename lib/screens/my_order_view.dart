import 'package:coffee_order_app/components/header_bar.dart';
import 'package:coffee_order_app/components/option_button.dart';
import 'package:coffee_order_app/components/order_detail.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/order_view/order_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrderView extends StatelessWidget {
  const MyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        key: const PageStorageKey('MyOrderView'),
        hideAppBar: false,
        appBar: const OrdinaryHBar(
          forHomeView: false,
          title: 'My Order',
          allowBackNavigation: false,
        ),
        child: Column(
          children: [
            Container(
              key: const PageStorageKey('MyOrderView_ContainerOverall'),
              width: double.infinity,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xFFF4F5F7), width: 3))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptionButton(
                      key: const PageStorageKey('MyOrderView_OptionONGOING'),
                      title: 'On going',
                      enabled: context.watch<OrderViewBloc>().state.viewOnGoing,
                      onPressed: (context) => context
                          .read<OrderViewBloc>()
                          .add(const ChangeView(true))),
                  const SizedBox(width: 40),
                  OptionButton(
                      key: const PageStorageKey('MyOrderView_OptionHISTORY'),
                      title: 'History',
                      enabled:
                          !context.watch<OrderViewBloc>().state.viewOnGoing,
                      onPressed: (context) => context
                          .read<OrderViewBloc>()
                          .add(const ChangeView(false))),
                ],
              ),
            ),
            ListView.custom(
                key: const PageStorageKey('MyOrderView_LIST'),
                shrinkWrap: true,
                childrenDelegate: SliverChildListDelegate(
                    context.watch<OrderViewBloc>().state.viewOnGoing
                        ? context
                            .watch<OrderViewBloc>()
                            .state
                            .onGoingOrders
                            .map((e) => OrderDetail(orderCart: e))
                            .toList()
                        : context
                            .watch<OrderViewBloc>()
                            .state
                            .historyOrders
                            .map((e) => OrderDetail(orderCart: e))
                            .toList()))
          ],
        ));
  }
}
