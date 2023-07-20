import 'package:coffee_order_app/components/coffee_listview.dart';
import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/repositories/assets/assets.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/home_view/home_view_bloc.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        key: const PageStorageKey('HomePageViewScreen'),
        appBar: OrdinaryHBar(
          forHomeView: true,
          username: context.watch<HomeViewBloc>().state.username,
          actions: [
            InkWell(
              onTap: () => BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateToMyCart()),
              child: SvgPicture.string(
                SvgAssets.cart_view_button,
                fit: BoxFit.cover,
              ),
            ),
            InkWell(
              onTap: () => BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateToProfile()),
              child: SvgPicture.string(
                SvgAssets.profile_view_active_button,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                LoyaltyCard(
                    levelUp: (context) =>
                        context.read<HomeViewBloc>().add(const LevelUpEvent()),
                    clicked: context.watch<HomeViewBloc>().state.clicked,
                    totalDrinks:
                        context.watch<HomeViewBloc>().state.totalDrinks)
              ],
            ),
          ),
          const SliverPadding(
              padding: EdgeInsets.only(
            top: 38,
          )),
          SliverToBoxAdapter(
            child: CoffeeListView(
                coffees: context.watch<HomeViewBloc>().state.coffees),
          )
        ]));
  }
}
