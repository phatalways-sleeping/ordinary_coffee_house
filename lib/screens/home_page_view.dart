import 'package:coffee_order_app/components/carousel_rewardsview.dart';
import 'package:coffee_order_app/components/coffee_listview.dart';
import 'package:coffee_order_app/components/coffee_productview.dart';
import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/components/persistent_header.dart';
import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/home_view/home_view_bloc.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
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
        hideAppBar: true,
        hideNavigationBar: isScrolledDown,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
          SliverPersistentHeader(
            floating: true,
              delegate: PersistentHeader(
                  maxExtentHeight: 140,
                  minExtentHeight: 120,
                  widget: OrdinaryHBar(
                    forHomeView: true,
                    username: context.watch<HomeViewBloc>().state.username,
                    actions: [
                      InkWell(
                        onTap: () => BlocProvider.of<NavigationBloc>(context)
                            .add(const NavigateToMyCart()),
                        child: SvgPicture.string(
                          SvgAssets.cart_view_button,
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFFF7F8FB), BlendMode.srcIn)
                        ),
                      ),
                      InkWell(
                        onTap: () => BlocProvider.of<NavigationBloc>(context)
                            .add(const NavigateToProfile()),
                        child: SvgPicture.string(
                          SvgAssets.profile_view_active_button,
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFFF7F8FB), BlendMode.srcIn)
                        ),
                      ),
                    ],
                  ))),
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
