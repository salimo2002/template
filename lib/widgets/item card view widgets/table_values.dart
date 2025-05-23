
import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class TableValues extends StatelessWidget {
  const TableValues({super.key, required this.value});
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        textAlign: TextAlign.center,
        value,
        style: FontStyleApp.black18.copyWith(
          fontSize: getResponsiveText(context, 16),
        ),
      ),
    );
  }
}