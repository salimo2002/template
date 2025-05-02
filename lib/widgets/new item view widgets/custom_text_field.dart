import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyType = TextInputType.text, this.validator,
    
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyType;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: TextFormField(
        validator: validator,
        keyboardType: keyType,
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
            fontSize: getResponsiveText(context, 12),
          ),
          fillColor: kWhite,
          filled: true,
          enabledBorder: borderStyle(),
          border: borderStyle(),
          focusedBorder: borderStyle(),
          errorBorder: borderErrorStyle(),
          focusedErrorBorder: borderErrorStyle(),
          errorStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent));
  }

  OutlineInputBorder borderErrorStyle() {
    return const OutlineInputBorder(borderSide: BorderSide(color: Colors.red));
  }
}
