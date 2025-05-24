import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/invoice%20details%20view/date_picker_field.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.canRead,
    this.prefixIcon,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? canRead;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onTap: () {
          DatePickerField();
        },
        readOnly: canRead == null ? false : true,
        validator: validator,
        keyboardType: keyType,
        controller: controller,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          label: Text(hintText, style: TextStyle(color: kBlueAccent)),
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
          errorStyle: TextStyle(fontWeight: FontWeight.bold),
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
