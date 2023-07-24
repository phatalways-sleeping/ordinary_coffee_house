import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/screens/base_screen.dart';
import 'package:coffee_order_app/states/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        hideAppBar: true,
        hideNavigationBar: true,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 175,),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                    SvgAssets.order_success,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Order Success',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF181D2D),
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Your order has been placed successfully.\nFor more details, go to my orders.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFAAAAAA),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const AnimatedCrossFade(
                      firstChild: Icon(Icons.check_circle,
                          color: Color.fromARGB(255, 101, 180, 102), size: 10),
                      secondChild: Icon(Icons.check_circle,
                          color: Color.fromARGB(255, 61, 143, 63), size: 30),
                      crossFadeState: CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 3000)),
                  const SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: () => BlocProvider.of<NavigationBloc>(context)
                        .add(const NavigateToMyOrder()),
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
                      'Track My Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ));
  }
}
