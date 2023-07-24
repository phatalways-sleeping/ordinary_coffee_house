import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdinaryCoffeeBBar extends StatelessWidget {
  const OrdinaryCoffeeBBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(height: 64, width: 324),
        margin: const EdgeInsets.symmetric(horizontal: 26).copyWith(bottom: 25),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x1E000000),
              blurRadius: 50,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => BlocProvider.of<NavigationBloc>(context)
                      .add(const NavigateToHomePage()),
                  child: state is HomePage
                      ? SvgPicture.string(SvgAssets.home_view_active_button)
                      : SvgPicture.string(SvgAssets.home_view_deactive_button),
                ),
                const SizedBox(width: 74),
                InkWell(
                  onTap: () => BlocProvider.of<NavigationBloc>(context)
                      .add(const NavigateToRewards()),
                  child: state is Rewards
                      ? SvgPicture.string(SvgAssets.rewards_view_active_button)
                      : SvgPicture.string(
                          SvgAssets.rewards_view_deactive_button),
                ),
                const SizedBox(width: 74),
                InkWell(
                  onTap: () => BlocProvider.of<NavigationBloc>(context)
                      .add(const NavigateToMyOrder()),
                  child: state is MyOrder
                      ? SvgPicture.string(SvgAssets.orders_view_active_button)
                      : SvgPicture.string(
                          SvgAssets.orders_view_deactive_button),
                ),
              ],
            );
          },
        ));
  }
}
