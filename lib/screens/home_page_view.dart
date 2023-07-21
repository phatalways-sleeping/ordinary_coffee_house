import 'package:coffee_order_app/components/carousel_rewardsview.dart';
import 'package:coffee_order_app/components/coffee_listview.dart';
import 'package:coffee_order_app/components/coffee_productview.dart';
import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/repositories/assets/assets.dart';
import 'package:coffee_order_app/repositories/models/models.dart';
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
          if (context.watch<HomeViewBloc>().state.drinkRewards.isNotEmpty)
            const SliverPadding(
              padding: EdgeInsets.only(left: 25, bottom: 10),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Spend your rewards!',
                  style: TextStyle(
                    color: Color(0xFF001833),
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          if (context.watch<HomeViewBloc>().state.drinkRewards.isNotEmpty)
            SliverToBoxAdapter(
                child: BlocSelector<HomeViewBloc, HomeViewState,
                    List<DrinkReward>>(
              selector: (state) => state.drinkRewards,
              builder: (context, state) {
                return CarouselRewardsView(
                  rewards: state
                      .map((reward) => CoffeeProductView(
                            product: reward.product,
                            inCarousel: true,
                          ))
                      .toList(),
                );
              },
            )),
          const SliverPadding(
              padding: EdgeInsets.only(
            top: 20,
          )),
          SliverToBoxAdapter(
            child: CoffeeListView(
                coffees: context.watch<HomeViewBloc>().state.coffees),
          ),
        ]));
  }
}
