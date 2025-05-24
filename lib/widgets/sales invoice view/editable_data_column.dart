import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class EditableDataColumn extends StatelessWidget {
  const EditableDataColumn({
    super.key,
    required this.text,
    required this.conttroller,
    this.onChanged,
  });

  final String text;
  final TextEditingController conttroller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: kBlueAccent,
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                text,
                style: FontStyleApp.white18.copyWith(
                  fontSize: getResponsiveText(context, 12),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
            color: Color(0xffd8d8d8),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: EditableText(
            textAlign: TextAlign.center,
            controller: conttroller,
            focusNode: FocusNode(),
            style: TextStyle(fontSize: 16, color: Colors.black),
            cursorColor: Colors.blue,
            backgroundCursorColor: Colors.transparent,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
