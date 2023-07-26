import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/screens/screens.dart';
import 'package:coffee_order_app/states/state_management.dart';
import 'package:flutter/material.dart';

class RedeemRewardsView extends StatelessWidget {
  const RedeemRewardsView({super.key});

  List<DrinkReward> _drinkRewards(List<RewardBase> rewards, int totalPoints) {
    return rewards
        .whereType<DrinkReward>()
        .toList()
        .where((element) => element.points <= totalPoints)
        .toList();
  }

  List<FreeshipVoucher> _freeshipVouchers(
      List<RewardBase> rewards, int totalPoints) {
    return rewards
        .whereType<FreeshipVoucher>()
        .toList()
        .where((element) => element.points <= totalPoints)
        .toList();
  }

  List<DiscountVoucher> _discountVouchers(
      List<RewardBase> rewards, int totalPoints) {
    return rewards
        .whereType<DiscountVoucher>()
        .toList()
        .where((element) => element.points <= totalPoints)
        .toList();
  }

  List<RewardBase> _rewardsList(
      VouchersEvent event, List<RewardBase> rewards, int totalPoints) {
    if (event == VouchersEvent.viewDiscount) {
      return _discountVouchers(rewards, totalPoints);
    } else if (event == VouchersEvent.viewFreeship) {
      return _freeshipVouchers(rewards, totalPoints);
    }
    return _drinkRewards(rewards, totalPoints);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        key: const PageStorageKey('RedeemRewardsView'),
        hideAppBar: false,
        hideNavigationBar: true,
        appBar: OrdinaryHBar(
          forHomeView: false,
          title: 'Redeem',
          allowBackNavigation: true,
          onBackNavigation: (context) =>
              BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateToRewards()),
        ),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeader(
                widget: OptionsBar(options: [
                  BlocSelector<RewardsBloc, RewardsState, VouchersEvent>(
                    selector: (state) => state.event,
                    builder: (context, state) {
                      return OptionButton(
                          key: const PageStorageKey('MyOrderView_OptionDRINKS'),
                          title: 'Drinks',
                          enabled: state == VouchersEvent.viewDrink,
                          onPressed: (context) => context
                              .read<RewardsBloc>()
                              .add(const ViewDrink()));
                    },
                  ),
                  BlocSelector<RewardsBloc, RewardsState, VouchersEvent>(
                    selector: (state) => state.event,
                    builder: (context, state) {
                      return OptionButton(
                          key: const PageStorageKey(
                              'MyOrderView_OptionFREESHIP'),
                          title: 'Freeship',
                          enabled: state == VouchersEvent.viewFreeship,
                          onPressed: (context) => context
                              .read<RewardsBloc>()
                              .add(const ViewFreeship()));
                    },
                  ),
                  BlocSelector<RewardsBloc, RewardsState, VouchersEvent>(
                    selector: (state) => state.event,
                    builder: (context, state) {
                      return OptionButton(
                          key: const PageStorageKey(
                              'MyOrderView_OptionDISCOUNT'),
                          title: 'Discount',
                          enabled: state == VouchersEvent.viewDiscount,
                          onPressed: (context) => context
                              .read<RewardsBloc>()
                              .add(const ViewDiscount()));
                    },
                  ),
                ]),
              ),
            ),
            BlocBuilder<RewardsBloc, RewardsState>(
              buildWhen: (previous, current) =>
                  previous.rewards != current.rewards ||
                  previous.event != current.event ||
                  previous.currentUser.totalPoints !=
                      current.currentUser.totalPoints,
              builder: (context, state) {
                return SliverList.list(
                    key: const PageStorageKey('RedeemRewardsView_LIST'),
                    children: state.rewards
                            .where((element) =>
                                element.points <= state.currentUser.totalPoints)
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
                            for (final reward in _rewardsList(state.event,
                                state.rewards, state.currentUser.totalPoints))
                              RedeemDetail(reward: reward),
                          ]);
              },
            ),
          ],
        ));
  }
}
