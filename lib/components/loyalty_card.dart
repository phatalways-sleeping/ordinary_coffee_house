import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoyaltyCard extends StatelessWidget {
  const LoyaltyCard({
    super.key,
    required this.totalDrinks,
    required this.levelUp,
    required this.clicked,
  });

  final int totalDrinks;
  final bool clicked;
  final void Function(BuildContext context) levelUp;

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

  int generateLatestDrinks() {
    if (clicked) return totalDrinks % 8;
    return totalDrinks % 8 == 0 ? 8 : totalDrinks % 8;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(maxWidth: double.infinity, maxHeight: 160),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 14),
      decoration: ShapeDecoration(
        color: generateColorBasedOnDrinks(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Loyalty card',
                  style: TextStyle(
                    color: Color(0xFFD7D7D7),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '${generateLatestDrinks()} / 8',
                style: const TextStyle(
                  color: Color(0xFFD7D7D7),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(top: 10),
              constraints: const BoxConstraints(minHeight: 61),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 8; i++)
                    if (i < generateLatestDrinks())
                      SvgPicture.string(
                        SvgAssets.coffee_drink_active,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      )
                    else
                      SvgPicture.string(
                        SvgAssets.coffee_drink_deactive,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                  if (generateLatestDrinks() == 8 && !clicked)
                    IconButton(
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: MaterialStateProperty.all(
                              Colors.black.withOpacity(0.5)),
                        ),
                        iconSize: 25,
                        color: Colors.green,
                        onPressed: () => levelUp(context),
                        icon: const Icon(Icons.arrow_upward_rounded)),
                ],
              )),
        ),
        if (generateLatestDrinks() == 8 && !clicked)
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'You are on a streak drink! Let\'s keep it up!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
      ]),
    );
  }
}
