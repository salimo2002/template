
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';

class TextFieldBarcode extends StatelessWidget {
  const TextFieldBarcode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 10),
        IconButton(
          color: kblueAccent,
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.barcode, color: kblueAccent),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintTextDirection: TextDirection.rtl,
              hintText: 'اسم المادة',
              fillColor: kWhite,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kblueAccent),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: kblueAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kblueAccent),
              ),
            ),
          ),
        ),
        SizedBox(width: 30),
        Text(
          'اسم المادة',
          style: TextStyle(fontSize: getResponsiveText(context, 15)),
        ),
        SizedBox(width: 30),
      ],
    );
  }
}
