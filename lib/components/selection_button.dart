import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectionButton extends StatelessWidget {
  const SelectionButton({
    super.key,
    this.asSvg = true,
    this.title,
    this.activeIcon,
    this.deactiveIcon,
    this.active = false,
    required this.onPressed,
  });

  final bool asSvg;
  final String? title;
  final String? activeIcon;
  final String? deactiveIcon;
  final bool active;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    if (!asSvg) {
      return InkWell(
        onTap: () => onPressed(context),
        splashColor: Colors.transparent,
        child: Container(
            constraints: const BoxConstraints.tightFor(width: 90, height: 35),
            decoration: ShapeDecoration(
              color: active ? const Color(0x66D7D7D7) : null,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 0.60, color: Color(0x66D7D7D7)),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
            child: Text(
              title!,
              style: const TextStyle(
                color: Color(0xFF001833),
                fontSize: 13,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
            )),
      );
    }
    return InkWell(
      splashColor: Colors.transparent,
        onTap: () => onPressed(context),
        child: SvgPicture.string(
          active ? activeIcon! : deactiveIcon!,
          fit: BoxFit.cover,
        ));
  }
}
