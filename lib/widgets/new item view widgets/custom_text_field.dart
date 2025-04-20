import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintTextDirection: TextDirection.rtl,
        hintText: hintText,
        hintStyle: FontStyleApp.blackCustom18.copyWith(
          fontSize: getResponsiveText(context, 14),
        ),
        fillColor: kWhite,
        filled: true,
        enabledBorder: borderStyle(),
        border: borderStyle(),
        focusedBorder: borderStyle(),
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(borderSide: BorderSide(color: kblueAccent));
  }
}
