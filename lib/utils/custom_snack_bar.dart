import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

SnackBar customSnackBar(BuildContext context, String message, Color color) {
  return SnackBar(
    backgroundColor: color,
    content: Text(
      message,
      style: FontStyleApp.white18.copyWith(
        fontSize: getResponsiveText(context, 12),
      ),
    ),
  );
}
