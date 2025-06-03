import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class CommentsTextField extends StatelessWidget {
  const CommentsTextField({
    super.key,
    required this.controller,
    this.keyType = TextInputType.text,
    this.validator,
    required this.maxLines,
    required this.label, required this.focusNode,
  });
  final TextEditingController controller;
  final TextInputType? keyType;
  final String? Function(String?)? validator;
  final int maxLines;
  final String label;
  final  FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.75,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          focusNode: focusNode,
          maxLines: maxLines,
          validator: validator,
          keyboardType: keyType,
          controller: controller,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: kBlueAccent),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            hintTextDirection: TextDirection.rtl,
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
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: kBorderTextFieldColor),
      borderRadius: BorderRadius.circular(18),
    );
  }

  OutlineInputBorder borderErrorStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(18),
    );
  }
}
