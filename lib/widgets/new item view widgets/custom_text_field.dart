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
    return SizedBox(
      height: 34,
      child: TextFormField(
        controller: controller,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
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
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent));
  }
}
