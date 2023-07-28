import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/screens/screens.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  late final ScrollController _scrollController = ScrollController()
    ..addListener(() {
      if (ScrollDirection.reverse ==
          _scrollController.position.userScrollDirection) {
        setState(() {
          isScrolledDown = true;
        });
      } else if (ScrollDirection.forward ==
          _scrollController.position.userScrollDirection) {
        setState(() {
          isScrolledDown = false;
        });
      }
    });

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastEaseInToSlowEaseOut,
  );

  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isScrolledDown = false;
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: BaseScreen(
          hideAppBar: true,
          hideNavigationBar: isScrolledDown,
          child: CustomScrollView(controller: _scrollController, slivers: [
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
                          child: SvgPicture.string(SvgAssets.cart_view_button,
                              fit: BoxFit.cover,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xFFF7F8FB), BlendMode.srcIn)),
                        ),
                        InkWell(
                          onTap: () => BlocProvider.of<NavigationBloc>(context)
                              .add(const NavigateToProfile()),
                          child: SvgPicture.string(
                              SvgAssets.profile_view_active_button,
                              fit: BoxFit.cover,
                              colorFilter: const ColorFilter.mode(
                                  Color(0xFFF7F8FB), BlendMode.srcIn)),
                        ),
                      ],
                    ))),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  LoyaltyCard(
                      levelUp: (context) => context
                          .read<HomeViewBloc>()
                          .add(const LevelUpEvent()),
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
          ])),
    );
  }
}
