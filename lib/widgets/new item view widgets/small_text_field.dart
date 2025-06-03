import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class SmallTextField extends StatelessWidget {
  const SmallTextField({super.key, required this.textEditingController});
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .15,
      child: SizedBox(
        height: 43,
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
            fillColor: kWhite,
            enabledBorder: borderStyle(),
            border: borderStyle(),
            focusedBorder: borderStyle(),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: const Color.fromARGB(255, 233, 228, 228)),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
