import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.initialValue});
  final String initialValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      child: TextFormField(
        initialValue: initialValue,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 240),
          hintTextDirection: TextDirection.rtl,
          fillColor: kWhite,
          filled: true,
          enabledBorder: borderStyle(),
          border: borderStyle(),
          focusedBorder: borderStyle(),
        ),
      ),
    );
  }
}

OutlineInputBorder borderStyle() {
  return OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent));
}
