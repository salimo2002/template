import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class TableLabels extends StatelessWidget {
  const TableLabels({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        textAlign: TextAlign.center,
        label,
        style: FontStyleApp.blueAccent18.copyWith(
          fontSize: getResponsiveText(context, 14),
        ),
      ),
    );
  }
}
