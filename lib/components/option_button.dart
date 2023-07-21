import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    super.key,
    required this.title,
    required this.enabled,
    required this.onPressed,
  });

  final String title;
  final bool enabled;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(context),
      splashColor: const Color(0xFF001833).withOpacity(0.1),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 120),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: enabled
                ? const Border(
                    bottom: BorderSide(
                      color: Color(0xFF001833),
                      width: 3,
                    ),
                  )
                : null),
        child: Text(
          title,
          style: TextStyle(
            color: enabled ? const Color(0xFF001833) : const Color(0xFFD7D7D7),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
