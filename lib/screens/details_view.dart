import 'package:coffee_order_app/components/components.dart';
import 'package:coffee_order_app/components/increase_decrease_button.dart';
import 'package:coffee_order_app/components/result_bottom_bar.dart';
import 'package:coffee_order_app/components/selection_button.dart';
import 'package:coffee_order_app/repositories/models/order_details.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:coffee_order_app/states/order_processing/order_processing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../repositories/assets/assets.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        hideAppBar: false,
        hideNavigationBar: false,
        customBottomBar: true,
        customNavigationBar: ResultsBottomBar(
          price: context.watch<OrderProcessingBloc>().state.orderDetails.price,
          forDetails: true,
          addToCart: (context) {
            BlocProvider.of<OrderProcessingBloc>(context)
                .add(const AddToCart());
            BlocProvider.of<NavigationBloc>(context)
                .add(const NavigateToMyCart());
          },
        ),
        appBar: OrdinaryHBar(
          forHomeView: false,
          title: 'Details',
          allowBackNavigation: true,
          actions: [
            InkWell(
              onTap: () => BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateToMyCart()),
              child: SvgPicture.string(
                SvgAssets.cart_view_button,
                fit: BoxFit.cover,
              ),
            ),
          ],
          onBackNavigation: (context) =>
              BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateBackFromDetailsView()),
        ),
        child: Container(
          constraints: const BoxConstraints(maxHeight: double.infinity),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: Image.asset(
                      context
                          .watch<OrderProcessingBloc>()
                          .state
                          .orderDetails
                          .product
                          .image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              SliverToBoxAdapter(
                  child: RichText(
                text: TextSpan(
                    text: context
                        .watch<OrderProcessingBloc>()
                        .state
                        .orderDetails
                        .product
                        .description,
                    style: const TextStyle(
                      color: Color(0xFF324A59),
                      fontSize: 13,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    )),
              )),
              const SliverPadding(padding: EdgeInsets.only(top: 20)),
              SliverToBoxAdapter(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                            context
                                .watch<OrderProcessingBloc>()
                                .state
                                .orderDetails
                                .product
                                .name,
                            style: const TextStyle(
                              color: Color(0xFF001833),
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      const IncDecButton()
                    ]),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              const SliverToBoxAdapter(
                  child: Divider(
                color: Color(0xFFF4F5F7),
                thickness: 1,
              )),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              SliverToBoxAdapter(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text('Shot',
                            style: TextStyle(
                              color: Color(0xFF001833),
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      SelectionButton(
                          asSvg: false,
                          title: 'Single',
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .shot ==
                              DrinkShot.single,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeShot(DrinkShot.single))),
                      const SizedBox(width: 20),
                      SelectionButton(
                          asSvg: false,
                          title: 'Double',
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .shot ==
                              DrinkShot.double,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeShot(DrinkShot.double)))
                    ]),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              const SliverToBoxAdapter(
                  child: Divider(
                color: Color(0xFFF4F5F7),
                thickness: 1,
              )),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              SliverToBoxAdapter(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text('Select',
                            style: TextStyle(
                              color: Color(0xFF001833),
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      SelectionButton(
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .drinkType ==
                              DrinkType.hot,
                          activeIcon: SvgAssets.select_choice_single_active,
                          deactiveIcon: SvgAssets.select_choice_single_deactive,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeSelect(DrinkType.hot))),
                      const SizedBox(width: 20),
                      SelectionButton(
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .drinkType ==
                              DrinkType.cold,
                          activeIcon: SvgAssets.select_choice_double_active,
                          deactiveIcon: SvgAssets.select_choice_double_deactive,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeSelect(DrinkType.cold))),
                    ]),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              const SliverToBoxAdapter(
                  child: Divider(
                color: Color(0xFFF4F5F7),
                thickness: 1,
              )),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              SliverToBoxAdapter(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text('Size',
                            style: TextStyle(
                              color: Color(0xFF001833),
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      SelectionButton(
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .drinkSize ==
                              DrinkSize.small,
                          activeIcon: SvgAssets.size_small_active,
                          deactiveIcon: SvgAssets.size_small_deactive,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeSize(DrinkSize.small))),
                      const SizedBox(width: 20),
                      SelectionButton(
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .drinkSize ==
                              DrinkSize.medium,
                          activeIcon: SvgAssets.size_medium_active,
                          deactiveIcon: SvgAssets.size_medium_deactive,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeSize(DrinkSize.medium))),
                      const SizedBox(width: 20),
                      SelectionButton(
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .drinkSize ==
                              DrinkSize.large,
                          activeIcon: SvgAssets.size_large_active,
                          deactiveIcon: SvgAssets.size_large_deactive,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeSize(DrinkSize.large))),
                    ]),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              const SliverToBoxAdapter(
                  child: Divider(
                color: Color(0xFFF4F5F7),
                thickness: 1,
              )),
              const SliverPadding(padding: EdgeInsets.only(top: 10)),
              SliverToBoxAdapter(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text('Ice',
                            style: TextStyle(
                              color: Color(0xFF001833),
                              fontSize: 16,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      SelectionButton(
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .iceLevel ==
                              IceLevel.less,
                          activeIcon: SvgAssets.ice_less_active,
                          deactiveIcon: SvgAssets.ice_less_deactive,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeIce(IceLevel.less))),
                      const SizedBox(width: 20),
                      SelectionButton(
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .iceLevel ==
                              IceLevel.normal,
                          activeIcon: SvgAssets.ice_normal_active,
                          deactiveIcon: SvgAssets.ice_normal_deactive,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeIce(IceLevel.normal))),
                      const SizedBox(width: 20),
                      SelectionButton(
                          active: context
                                  .watch<OrderProcessingBloc>()
                                  .state
                                  .orderDetails
                                  .iceLevel ==
                              IceLevel.more,
                          activeIcon: SvgAssets.ice_more_active,
                          deactiveIcon: SvgAssets.ice_more_deactive,
                          onPressed: (context) =>
                              BlocProvider.of<OrderProcessingBloc>(context)
                                  .add(const ChangeIce(IceLevel.more))),
                    ]),
              ),
            ],
          ),
        ));
  }
}
