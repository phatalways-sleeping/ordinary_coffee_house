import 'package:coffee_order_app/components/navigation_bottom_bar.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    this.hideNavigationBar = false,
    this.hideAppBar = false,
    this.customBottomBar = false,
    this.customNavigationBar,
    required this.child,
    this.appBar = const PreferredSize(
      preferredSize: Size.fromHeight(64),
      child: SizedBox.shrink(),
    ),
  }) : assert(!hideNavigationBar || !customBottomBar);

  final bool hideNavigationBar;
  final bool hideAppBar;
  final bool customBottomBar;
  final Widget child;
  final PreferredSizeWidget appBar;
  final Widget? customNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hideAppBar ? null : appBar,
      backgroundColor: const Color(0xFFECF8F9),
      body: Stack(
        alignment: Alignment.center,
        children: [
          child,
          if (!hideNavigationBar)
            Positioned(
              bottom: 0,
              child: customBottomBar
                  ? customNavigationBar!
                  : const OrdinaryCoffeeBBar(),
            ),
        ],
      ),
    );
  }
}
