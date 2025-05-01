import 'package:flutter/material.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_text_form_field.dart';

class SmallTextField extends StatelessWidget {
  const SmallTextField({super.key, required this.textEditingController});
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .15,
      child: SizedBox(
        height: 34,
        child: TextField(
          controller: textEditingController,
          readOnly: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 16,
            ),
            hintTextDirection: TextDirection.rtl,
            filled: true,
            fillColor: Colors.white10,
            enabledBorder: borderStyle(),
            border: borderStyle(),
            focusedBorder: borderStyle(),
          ),
        ),
      ),
    );
  }
}
