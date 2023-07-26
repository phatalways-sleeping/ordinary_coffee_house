import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:coffee_order_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coffee_order_app/states/state_management.dart' show BlocProvider, NavigateToHomePage, NavigationBloc;

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 3), () {
      BlocProvider.of<NavigationBloc>(context).add(const NavigateToHomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideNavigationBar: true,
      child: SafeArea(
          child: GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/splash_screen.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color(0x5E1D2335).withOpacity(0.4),
                )
              ],
            ),
            Positioned(
              top: 260,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.string(
                      SvgAssets.spash_screen_coffee,
                      width: 145,
                      height: 150,
                      // ignore: deprecated_member_use
                      color: Colors.white,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Ordinary Coffee House',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFFFAF6),
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
