import 'package:coffee_order_app/states/order_processing/order_processing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncDecButton extends StatelessWidget {
  const IncDecButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(width: 90, height: 35),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.60, color: Color(0x66D7D7D7)),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
            splashColor: Colors.transparent,
            onTap: () => BlocProvider.of<OrderProcessingBloc>(context)
                .add(const ChangeAmount(-1)),
            child: const Text(
              '-',
              style: TextStyle(
                color: Color(0xFF001833),
                fontSize: 15,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
            )),
        const SizedBox(width: 20),
        Text(
          context
              .watch<OrderProcessingBloc>()
              .state
              .orderDetails
              .amount
              .toString(),
          style: const TextStyle(
            color: Color(0xFF001833),
            fontSize: 14,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 20),
        InkWell(
            splashColor: Colors.transparent,
            onTap: () => BlocProvider.of<OrderProcessingBloc>(context)
                .add(const ChangeAmount(1)),
            child: const Text(
              '+',
              style: TextStyle(
                color: Color(0xFF001833),
                fontSize: 15,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
            ))
      ]),
    );
  }
}
