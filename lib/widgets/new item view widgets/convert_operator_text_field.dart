import 'package:flutter/material.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';
import 'package:template/widgets/new%20item%20view%20widgets/small_text_field.dart';

class ConvertOperatorTextField extends StatelessWidget {
  const ConvertOperatorTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.keyType = TextInputType.text,
    required this.convertOperatorTextField,
  });
  final TextEditingController textEditingController;
  final TextEditingController convertOperatorTextField;
  final String hintText;
  final TextInputType? keyType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(width: 10),
        SmallTextField(textEditingController: textEditingController),
        const SizedBox(width: 2),
        Expanded(
          child: CustomTextField(
            
            keyType: keyType,
            hintText: hintText,
            controller: convertOperatorTextField,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
