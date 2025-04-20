import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class PartsTitle extends StatelessWidget {
  const PartsTitle({super.key, required this.title, required this.color});
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 29,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Center(
        child: FittedBox(
          child: Text(
            style: FontStyleApp.white18.copyWith(
              fontSize: getResponsiveText(context, 14),
            ),
            title,
          ),
        ),
      ),
    );
  }
}
