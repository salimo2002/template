import 'package:flutter/material.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/row_name_classifications.dart';

class SmallTextField extends StatelessWidget {
  const SmallTextField({super.key, required this.textEditingController});
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .15,
      child: TextField(
        controller: textEditingController,
        readOnly: true,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          filled: true,
          fillColor: Colors.white10,
          enabledBorder: borderStyle(),
          border: borderStyle(),
          focusedBorder: borderStyle(),
        ),
      ),
    );
  }
}
