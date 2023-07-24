import 'package:coffee_order_app/models/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdinaryHBar extends StatelessWidget implements PreferredSizeWidget {
  const OrdinaryHBar({
    super.key,
    this.forHomeView = true,
    this.allowBackNavigation = false,
    this.title,
    this.actions = const [],
    this.username,
    this.onBackNavigation,
  });

  final bool forHomeView;
  final bool allowBackNavigation;
  final void Function(BuildContext context)? onBackNavigation;
  final String? title;
  final String? username;
  final List<InkWell> actions;

  @override
  Widget build(BuildContext context) {
    if (forHomeView) {
      return SafeArea(
        child: Container(
          decoration: ShapeDecoration(
            color: const Color(0xFF324A59).withOpacity(0.9),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
            ),
          ),
          constraints: const BoxConstraints.expand(height: 85),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
          child: Row(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good morning',
                    style: TextStyle(
                      color: Color(0xFFF7F8FB),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    username!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFF7F8FB),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            ...actions.map((action) => Padding(
                  padding: actions.indexOf(action) == actions.length - 1
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(right: 20),
                  child: action,
                ))
          ]),
        ),
      );
    }
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints.expand(height: 64),
        margin: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(children: [
          if (allowBackNavigation)
            InkWell(
              onTap: () => onBackNavigation!(context),
              child: SvgPicture.string(SvgAssets.navigation_back_button),
            ),
          if (title != null)
            Expanded(
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF001833),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ...actions.map((action) => Padding(
                padding: actions.indexOf(action) == actions.length - 1
                    ? EdgeInsets.zero
                    : const EdgeInsets.only(right: 20),
                child: action,
              ))
        ]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 100);
}
