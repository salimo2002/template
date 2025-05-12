import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class RowNameClassifications extends StatelessWidget {
  const RowNameClassifications({
    super.key,
    required this.hintText,
    required this.categoryName,
    required this.onPressed,
    this.onChanged,
  });
  final String hintText;
  final TextEditingController categoryName;
  final VoidCallback onPressed;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(onPressed: onPressed, icon: Icon(Icons.search)),
        ),
        Flexible(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * .808,
            height: 33,
            child: TextFormField(
              onChanged: onChanged,
              controller: categoryName,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintTextDirection: TextDirection.rtl,
                hintText: hintText,
                fillColor: kWhite,
                filled: true,
                enabledBorder: borderStyle(),
                border: borderStyle(),
                focusedBorder: borderStyle(),
                errorBorder: borderErrorStyle(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent));
  }

  OutlineInputBorder borderErrorStyle() {
    return const OutlineInputBorder(borderSide: BorderSide(color: Colors.red));
  }
}
