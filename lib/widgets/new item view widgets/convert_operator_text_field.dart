import 'package:flutter/material.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';
import 'package:template/widgets/new%20item%20view%20widgets/small_text_field.dart';

class ConvertOperatorTextField extends StatelessWidget {
  const ConvertOperatorTextField({
    super.key,
    required this.textEditingController,
    required this.label,
    required this.hintText,
    this.keyType = TextInputType.text, required this.convertOperatorTextField,
  });
  final TextEditingController textEditingController;
   final TextEditingController convertOperatorTextField;
  final String label;
  final String hintText;
  final TextInputType? keyType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(width: 5),
        SmallTextField(textEditingController: textEditingController),
        const SizedBox(width: 5),
        Expanded(
          child: CustomTextField(
            keyType: keyType,
            hintText: hintText,
            controller: convertOperatorTextField,
          ),
        ),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(fontSize: getResponsiveText(context, 12))),
        const SizedBox(width: 10),
      ],
    );
  }
}
