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
  });
  final String hintText;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 5),
        IconButton(
          color: kblueAccent,
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.barcode, color: kblueAccent),
        ),
        SizedBox(width: 10),
        Expanded(child: CustomTextField(hintText: hintText)),
        SizedBox(width: 30),
        Text(label, style: TextStyle(fontSize: getResponsiveText(context, 15))),
        SizedBox(width: 30),
      ],
    );
  }
}
