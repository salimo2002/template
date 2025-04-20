import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';

class TextFieldDetails extends StatelessWidget {
  const TextFieldDetails({
    super.key,
    required this.hintText,
    required this.label,
  });
  final String hintText;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintTextDirection: TextDirection.rtl,
              hintText: hintText,
              fillColor: kWhite,
              filled: true,
              enabledBorder: borderStyle(),
              border: borderStyle(),
              focusedBorder: borderStyle(),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Text(label, style: TextStyle(fontSize: getResponsiveText(context, 15))),
        const SizedBox(width: 30),
      ],
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(borderSide: BorderSide(color: kblueAccent));
  }
}
