import 'package:coffee_order_app/repositories/models/models.dart';
import 'package:coffee_order_app/states/rewards/rewards_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RedeemDetail extends StatelessWidget {
  const RedeemDetail({super.key, required this.reward});

  final Reward reward;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: 61, width: 82),
              child: Image.asset(
                reward.product.image,
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
                  reward.product.name,
                  style: const TextStyle(
                    color: Color(0xFF324A59),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${reward.validUntil.day}.${reward.validUntil.month}.${reward.validUntil.year}',
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

                BlocProvider.of<RewardsCubit>(context).claimReward(reward);
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
                '${reward.points} pts',
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
