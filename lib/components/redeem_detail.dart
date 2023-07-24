import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/states/rewards/rewards_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedeemDetail extends StatelessWidget {
  const RedeemDetail({super.key, required this.reward, this.masked = false});

  final RewardBase reward;
  final bool masked;

  @override
  Widget build(BuildContext context) {
    if (reward is DrinkReward) {
      final drinkReward = reward as DrinkReward;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints.tightFor(height: 61, width: 82),
                child: Image.asset(
                  drinkReward.product.image,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drinkReward.product.name,
                    style: const TextStyle(
                      color: Color(0xFF324A59),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${drinkReward.validUntil.day}.${drinkReward.validUntil.month}.${drinkReward.validUntil.year}',
                    style: const TextStyle(
                      color: Color(0x7F324A59),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (!masked)
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0x38324A59),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        duration: const Duration(seconds: 2),
                        content: const Text(
                          'Claimed redeem!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );

                    BlocProvider.of<RewardsBloc>(context)
                        .add(ClaimReward(drinkReward));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF324A59),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    fixedSize: const Size(80, 30),
                  ),
                  child: Text(
                    '${drinkReward.points} pts',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  )),
          ],
        ),
      );
    }
    if (reward is FreeshipVoucher) {
      final freeshipVoucher = reward as FreeshipVoucher;
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Free shipping',
                    style: TextStyle(
                      color: Color(0xFF324A59),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${freeshipVoucher.validUntil.day}.${freeshipVoucher.validUntil.month}.${freeshipVoucher.validUntil.year}',
                    style: const TextStyle(
                      color: Color(0x7F324A59),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'CODE: ${freeshipVoucher.code.substring(0, 5).toUpperCase()}',
                    style: const TextStyle(
                      color: Color(0x7F324A59),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (!masked)
              ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0x38324A59),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        duration: const Duration(seconds: 2),
                        content: const Text(
                          'Claimed redeem!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );

                    BlocProvider.of<RewardsBloc>(context)
                        .add(ClaimReward(freeshipVoucher));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF324A59),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    fixedSize: const Size(80, 30),
                  ),
                  child: Text(
                    '${freeshipVoucher.points} pts',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  )),
          ],
        ),
      );
    }
    final discountVoucher = reward as DiscountVoucher;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discount ${(discountVoucher.discount * 100).toInt()}%',
                  style: const TextStyle(
                    color: Color(0xFF324A59),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${discountVoucher.validUntil.day}.${discountVoucher.validUntil.month}.${discountVoucher.validUntil.year}',
                  style: const TextStyle(
                    color: Color(0x7F324A59),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'CODE: ${discountVoucher.code.substring(0, 5).toUpperCase()}',
                  style: const TextStyle(
                    color: Color(0x7F324A59),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (!masked)
            ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0x38324A59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      duration: const Duration(seconds: 2),
                      content: const Text(
                        'Claimed redeem!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );

                  BlocProvider.of<RewardsBloc>(context)
                      .add(ClaimReward(discountVoucher));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF324A59),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  fixedSize: const Size(80, 30),
                ),
                child: Text(
                  '${discountVoucher.points} pts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                )),
        ],
      ),
    );
  }
}
