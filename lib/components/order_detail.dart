import 'package:coffee_order_app/repositories/assets/assets.dart';
import 'package:coffee_order_app/repositories/models/order_cart.dart';
import 'package:coffee_order_app/states/order_view/order_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key, required this.orderCart});

  final OrderCart orderCart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 31, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${orderCart.date.day} ${months[orderCart.date.month - 1]} | ${orderCart.date.hour}:${orderCart.date.minute} ${orderCart.date.hour > 12 ? 'PM' : 'AM'}',
                style: const TextStyle(
                  color: Color(0x38324A59),
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.string(
                    SvgAssets.coffee_order_view,
                    fit: BoxFit.cover,
                    height: 15,
                    width: 15,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    orderCart.items.map((item) => item.product.name).join(','),
                    style: const TextStyle(
                      color: Color(0xFF324A59),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.string(
                    SvgAssets.address,
                    fit: BoxFit.cover,
                    height: 15,
                    width: 15,
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                      text: context
                          .read<OrderViewBloc>()
                          .state
                          .currentUser
                          .address,
                      style: const TextStyle(
                        color: Color(0xFF324A59),
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 31,
          top: 20,
          child: Text(
            '\$${orderCart.totalPrice().toStringAsFixed(2)}',
            style: const TextStyle(
              color: Color(0xFF324A59),
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
