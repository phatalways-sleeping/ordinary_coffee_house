import 'package:coffee_order_app/repositories/models/order_details.dart';
import 'package:flutter/material.dart';

const months = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

class RewardDetail extends StatelessWidget {
  const RewardDetail({super.key, required this.details});

  final OrderDetails details;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Color(0xFFF4F5F7), width: 1),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details.product.name,
                  style: const TextStyle(
                    color: Color(0xFF324A59),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${details.orderedAt.day} ${months[details.orderedAt.month - 1]} | ${details.orderedAt.hour}:${details.orderedAt.minute} ${details.orderedAt.hour > 12 ? 'PM' : 'AM'}',
                  style: const TextStyle(
                    color: Color(0x38324A59),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Text(
            '+ ${details.product.rewardPoints * details.amount} Pts',
            style: const TextStyle(
              color: Color(0xFF324A59),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
