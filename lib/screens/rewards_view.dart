import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/components/points_redeem_card.dart';
import 'package:coffee_order_app/components/reward_detail.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/rewards/rewards_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        hideAppBar: false,
        appBar: const OrdinaryHBar(
          forHomeView: false,
          title: 'Rewards',
          allowBackNavigation: false,
        ),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: LoyaltyCard(
                  levelUp: (context) => context.read<RewardsCubit>().levelUp(),
                  clicked: context.watch<RewardsCubit>().state.clicked,
                  totalDrinks: context
                      .watch<RewardsCubit>()
                      .state
                      .currentUser
                      .totalDrinks)),
          const SliverPadding(
              padding: EdgeInsets.only(
            top: 16,
          )),
          SliverToBoxAdapter(
              child: PointsRedeemCard(
            totalDrinks:
                context.watch<RewardsCubit>().state.currentUser.totalDrinks,
            totalPoints:
                context.watch<RewardsCubit>().state.currentUser.totalPoints,
          )),
          const SliverPadding(
              padding: EdgeInsets.only(
            top: 38,
          )),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            sliver: SliverToBoxAdapter(
                child: Text(
              'History Rewards',
              style: TextStyle(
                color: Color(0xFF324A59),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
          const SliverPadding(
              padding: EdgeInsets.only(
            top: 25,
          )),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            sliver: SliverList.list(children: [
              for (final order
                  in context.watch<RewardsCubit>().state.currentUser.allCarts)
                for (final item in order.items)
                  RewardDetail(
                    details: item,
                  )
            ]),
          )
        ]));
  }
}
