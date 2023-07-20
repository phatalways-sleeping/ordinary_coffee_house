import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/components/redeem_detail.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:coffee_order_app/states/rewards/rewards_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedeemRewardsView extends StatelessWidget {
  const RedeemRewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        hideAppBar: false,
        appBar: OrdinaryHBar(
          forHomeView: false,
          title: 'Redeem',
          allowBackNavigation: true,
          onBackNavigation: (context) =>
              BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateToRewards()),
        ),
        child: SizedBox(
          height: double.infinity,
          child: ListView.custom(
              shrinkWrap: true,
              childrenDelegate: SliverChildListDelegate(context
                      .watch<RewardsCubit>()
                      .state
                      .rewards
                      .where((element) =>
                          element.points <=
                          context
                              .watch<RewardsCubit>()
                              .state
                              .currentUser
                              .totalPoints)
                      .isEmpty
                  ? [
                      const Center(
                        child: Text(
                          'More drinks, More redeems!',
                          style: TextStyle(
                            color: Color(0xFF324A59),
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]
                  : [
                      for (final reward in context
                          .watch<RewardsCubit>()
                          .state
                          .rewards
                          .where((element) =>
                              element.points <=
                              context
                                  .watch<RewardsCubit>()
                                  .state
                                  .currentUser
                                  .totalPoints))
                        RedeemDetail(reward: reward),
                    ])),
        ));
  }
}
