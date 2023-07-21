import 'package:coffee_order_app/repositories/models/order_details.dart';
import 'package:coffee_order_app/states/cart_view/cart_view_bloc.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderDetailsItem extends StatelessWidget {
  const OrderDetailsItem({
    super.key,
    required this.orderDetails,
  });

  final OrderDetails orderDetails;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
          openThreshold: 0.2,
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => BlocProvider.of<CartViewBloc>(context)
                  .add(RemoveFromCart(orderDetails)),
              icon: Icons.delete_outline_outlined,
              backgroundColor: const Color(0xFFFFE5E5),
              foregroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 36),
            ),
          ]),
      child: InkWell(
        onTap: () {
          BlocProvider.of<CartViewBloc>(context)
              .add(InspectOrder(orderDetails));
          BlocProvider.of<NavigationBloc>(context).add(const NavigateToDetails());
        },
        splashColor: Colors.transparent,
        child: Container(
            constraints: const BoxConstraints.tightFor(height: 100),
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
            decoration: ShapeDecoration(
              color: const Color(0xFFF7F8FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    orderDetails.product.image,
                    width: 82,
                    height: 61,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      orderDetails.product.name,
                      style: const TextStyle(
                        color: Color(0xFF001833),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      orderDetails.description,
                      style: const TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'x ${orderDetails.amount}',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5699999928474426),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '\$${orderDetails.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF001833),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
