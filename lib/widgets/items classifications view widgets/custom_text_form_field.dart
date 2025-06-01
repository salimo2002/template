import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.categoryNameUpdate,
    this.validator,
  });
  final String? Function(String?)? validator;
  final TextEditingController categoryNameUpdate;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        validator: validator,
        controller: categoryNameUpdate,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          label: Text('اسم التصنيف'),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          fillColor: kWhite,
          filled: true,
          enabledBorder: borderStyle(),
          border: borderStyle(),
          focusedBorder: borderStyle(),
          errorBorder: borderErrorStyle(),
          focusedErrorBorder: borderErrorStyle(),
          errorStyle: TextStyle(fontWeight: FontWeight.bold)  ,
        ),
      ),
    );
  }
}

OutlineInputBorder borderStyle() {
  return OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent));
}

OutlineInputBorder borderErrorStyle() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(8),
  );
}
