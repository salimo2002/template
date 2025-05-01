import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class RowNameClassifications extends StatelessWidget {
  const RowNameClassifications({
    super.key,
    required this.hintText,
    required this.categoryName,
    required this.globalKey,
    required this.onPressed,
  });
  final String hintText;
  final TextEditingController categoryName;
  final GlobalKey<FormState> globalKey;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.add_circle),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * .808,
              height: 33,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ادخل اسم التصنيف';
                  }
                  return null;
                },
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
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent));
  }

  OutlineInputBorder borderErrorStyle() {
    return const OutlineInputBorder(borderSide: BorderSide(color: Colors.red));
  }
}
