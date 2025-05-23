import 'package:flutter/material.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class TextFieldAndDetails extends StatelessWidget {
  const TextFieldAndDetails({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyType = TextInputType.text,
    this.validator,
    this.icon,
    this.canRead,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyType;
  final String? Function(String?)? validator;
  final Widget? icon;
  final bool? canRead;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        spacing: 25,
        children: [
          Expanded(
            child: CustomTextField(
              canRead: canRead,
              suffixIcon: icon,
              validator: validator,
              hintText: hintText,
              controller: controller,
              keyType: keyType,
            ),
          ),
        ],
      ),
    );
  }
}
