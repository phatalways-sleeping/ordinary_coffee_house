import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/models/order_cart.dart';
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
  const OrderDetail({
    super.key,
    required this.orderCart,
    this.swipeToDismiss = false,
  });

  final OrderCartPayed orderCart;
  final bool swipeToDismiss;

  @override
  Widget build(BuildContext context) {
    final component = Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 5,
                offset: Offset(0, 4),
              ),
            ],
          ),
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
                  SizedBox(
                    width: 320,
                    child: RichText(
                      maxLines: 3,
                      text: TextSpan(
                        text: orderCart.items
                            .map((item) => item.product.name)
                            .join(','),
                        style: const TextStyle(
                          color: Color(0xFF324A59),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
          right: 40,
          top: 20,
          child: Text(
            '\$${orderCart.price.toStringAsFixed(2)}',
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
    if (swipeToDismiss) {
      return Dismissible(
        direction: DismissDirection.startToEnd,
        key: UniqueKey(),
        background: const ColoredBox(color: Colors.green),
        onDismissed: (direction) {
          context.read<OrderViewBloc>().add(AddCartToHistory(orderCart));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.white.withOpacity(0.4),
              duration: const Duration(seconds: 1),
              content: const Text(
                'Order added to history',
                style: TextStyle(
                  color: Color.fromARGB(255, 60, 111, 61),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
        child: component,
      );
    }
    return component;
  }
}
