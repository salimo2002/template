import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.initValue = '',
  });

  final String hintText;
  final String initValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initValue,
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
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(borderSide: BorderSide(color: kblueAccent));
  }
}
