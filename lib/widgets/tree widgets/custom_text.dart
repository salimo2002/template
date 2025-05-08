import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      style: FontStyleApp.black18.copyWith(
        fontSize: getResponsiveText(context, 12),
      ),
      text,
    );
  }
}
