import 'package:flutter/material.dart';



class OptionsBar extends StatelessWidget {
  const OptionsBar({
    super.key,
    required this.options,
  });

  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFFF4F5F7), width: 3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final option in options) ...[
            option,
            if (option != options.last) const SizedBox(width: 10),
          ]
        ],
      ),
    );
  }
}
