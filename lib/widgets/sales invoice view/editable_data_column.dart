import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class EditableDataColumn extends StatelessWidget {
  const EditableDataColumn({
    super.key,
    required this.text,
    required this.conttroller,
    this.onChanged,
    this.isNumericOnly = false, required this.focusNode,
  });
  final FocusNode focusNode;
  final String text;
  final TextEditingController conttroller;
  final void Function(String)? onChanged;
  final bool isNumericOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
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
            color: const Color(0xffd8d8d8),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: EditableText(
            textAlign: TextAlign.center,
            controller: conttroller,
            focusNode: focusNode,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            cursorColor: Colors.blue,
            backgroundCursorColor: Colors.transparent,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            inputFormatters:
                isNumericOnly
                    ? [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,4}'),
                      ),
                    ]
                    : [],
          ),
        ),
      ],
    );
  }
}
