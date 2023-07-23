import 'package:coffee_order_app/components/header_bar.dart';
import 'package:coffee_order_app/components/option_button.dart';
import 'package:coffee_order_app/components/options_bar.dart';
import 'package:coffee_order_app/components/order_detail.dart';
import 'package:coffee_order_app/components/persistent_header.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/order_view/order_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  late final ScrollController _scrollController = ScrollController()..addListener(() {
    if(ScrollDirection.reverse == _scrollController.position.userScrollDirection) {
      setState(() {
        isScrolledDown = true;
      });
    } else if(ScrollDirection.forward == _scrollController.position.userScrollDirection) {
      setState(() {
        isScrolledDown = false;
      });
    }
  });
  bool isScrolledDown = false;
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
        hideNavigationBar: isScrolledDown,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeader(
                widget: OptionsBar(options: [
                  OptionButton(
                      key: const PageStorageKey('MyOrderView_OptionONGOING'),
                      title: 'On going',
                      enabled: context.watch<OrderViewBloc>().state.viewOnGoing,
                      onPressed: (context) => context
                          .read<OrderViewBloc>()
                          .add(const ChangeView(true))),
                  OptionButton(
                      key: const PageStorageKey('MyOrderView_OptionHISTORY'),
                      title: 'History',
                      enabled:
                          !context.watch<OrderViewBloc>().state.viewOnGoing,
                      onPressed: (context) => context
                          .read<OrderViewBloc>()
                          .add(const ChangeView(false))),
                ]),
              ),
            ),
            SliverList.list(
                key: const PageStorageKey('MyOrderView_LIST'),
                children: context.watch<OrderViewBloc>().state.viewOnGoing
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
                        .toList()),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100))
          ],
        ));
  }
}
