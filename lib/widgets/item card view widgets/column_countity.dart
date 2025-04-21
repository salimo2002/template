import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class ColumnCountity extends StatelessWidget {
  const ColumnCountity({
    super.key,
    required this.nameCountity,
    required this.countity,
  });
  final String nameCountity;
  final String countity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          nameCountity,
          style: FontStyleApp.blueAccent18.copyWith(
            fontSize: getResponsiveText(context, 14),
          ),
        ),
        SizedBox(height: 5),
        Text(
          countity,
          style: FontStyleApp.blackCustom18.copyWith(
            fontSize: getResponsiveText(context, 14),
          ),
        ),
      ],
    );
  }
}
