import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultsBottomBar extends StatelessWidget {
  const ResultsBottomBar({
    super.key,
    this.forDetails = true,
    required this.price,
    this.addToCart,
    this.checkOut,
  });

  final bool forDetails;
  final double price;
  final void Function(BuildContext context)? addToCart;
  final void Function(BuildContext context)? checkOut;

  @override
  Widget build(BuildContext context) {
    if (forDetails) {
      return Container(
          constraints: BoxConstraints.loose(const Size(360, 100)),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      color: Color(0xFF001833),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFF001833),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () => addToCart!(context),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(360, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF324A59),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                  child: const Text(
                    'Add to cart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ))
            ],
          ));
    }

    return Container(
        constraints: BoxConstraints.loose(const Size(360, 70)),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(
                    color: Color(0x38001733),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF001833),
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () => checkOut!(context),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(200, 50),
                  ),
                  
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF324A59),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.string(
                      SvgAssets.cart_view_button,
                      fit: BoxFit.cover,
                      // ignore: deprecated_member_use
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Check out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
