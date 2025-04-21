import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class TextFieldAndBarcode extends StatelessWidget {
  const TextFieldAndBarcode({
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
        SizedBox(width: 5),
        IconButton(
          color: kBlueAccent,
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.barcode, color: kBlueAccent),
        ),
        SizedBox(width: 10),
        Expanded(
          child: CustomTextField(hintText: hintText, controller: controller),
        ),
        SizedBox(width: 30),
        Text(label, style: TextStyle(fontSize: getResponsiveText(context, 12))),
        SizedBox(width: 30),
      ],
    );
  }
}
