import 'package:coffee_order_app/repositories/assets/svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../states/navigation/navigation_bloc.dart';

class PointsRedeemCard extends StatelessWidget {
  const PointsRedeemCard({
    super.key,
    required this.totalPoints,
    required this.totalDrinks,
  });

  final int totalPoints;
  final int totalDrinks;

  Color generateColorBasedOnDrinks() {
    if (totalDrinks < 8) {
      // return const Color(0xFF8C635E);
      return const Color(0xFF324A59);
    } else if (totalDrinks < 30) {
      return const Color(0xFF324A59);
    } else if (totalDrinks < 50) {
      // return const Color(0xFFD4AF37);
      return const Color(0xFF324A59);
    }
    // return const Color.fromARGB(255, 124, 113, 113);
    return const Color(0xFF324A59);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints:
              const BoxConstraints(maxWidth: double.infinity, maxHeight: 125),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          decoration: ShapeDecoration(
            color: generateColorBasedOnDrinks(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Points:',
                      style: TextStyle(
                        color: Color(0xFFD7D7D7),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$totalPoints',
                      style: const TextStyle(
                        color: Color(0xFFD7D7D7),
                        fontSize: 25,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 15,
          right: 25,
          child: SvgPicture.string(SvgAssets.redeem_card_mask),
        ),
        Positioned(
          right: 60,
          bottom: 55,
          child: ElevatedButton(
              onPressed: () => BlocProvider.of<NavigationBloc>(context)
                  .add(const NavigateToRedeeemRewards()),
              style: ElevatedButton.styleFrom(
                backgroundColor: generateColorBasedOnDrinks().withGreen(60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                maximumSize: const Size(double.infinity, 60),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
              ),
              child: const Text(
                'Redeem drinks',
                style: TextStyle(
                  color: Color(0xFFD7D7D7),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              )),
        )
      ],
    );
  }
}
