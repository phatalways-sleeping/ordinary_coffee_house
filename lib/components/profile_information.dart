import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/assets/assets.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({
    super.key,
    required this.iconLeft,
    required this.title,
    required this.onComplete,
    required this.initialValue,
  });

  final String iconLeft;
  final String title;
  final String initialValue;
  final void Function(BuildContext context, String payload) onComplete;

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  late final TextEditingController _controller;
  bool enabled = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.initialValue.isEmpty ? 'Not set' : widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(255, 163, 164, 166),
                    shape: OvalBorder(),
                  ),
                ),
                SvgPicture.string(widget.iconLeft,
                    height: 24, width: 24, fit: BoxFit.cover)
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Form(
                child: TextFormField(
                  autofocus: true,
                  maxLines: null,
                  readOnly: !enabled,
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Color(0xFF324A59),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(4.0),
                      labelText: widget.title,
                      labelStyle: const TextStyle(
                        color: Color(0x38001733),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                if (!enabled) {
                  widget.onComplete(context, _controller.text);
                }
                setState(() {
                  enabled = !enabled;
                });
              },
              child: SvgPicture.string(SvgAssets.modify,
                  height: 24, width: 24, fit: BoxFit.cover),
            )
          ],
        ));
  }
}
