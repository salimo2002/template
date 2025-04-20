import 'package:flutter/material.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class TextFieldAndDetails extends StatelessWidget {
  const TextFieldAndDetails({
    super.key,
    required this.hintText,
    required this.label,
     required this.controller,
  });
  final String hintText;
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(width: 5),
        Expanded(
          child: CustomTextField(hintText: hintText, controller: controller,),
        ),
        const SizedBox(width: 20),
        Text(label, style: TextStyle(fontSize: getResponsiveText(context, 12))),
        const SizedBox(width: 10),
      ],
    );
  }
}
