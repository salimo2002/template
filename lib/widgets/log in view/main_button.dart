import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.label,
  });
  final VoidCallback onTap;
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: kBlueAccent),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            label,
            style: FontStyleApp.white18.copyWith(
              fontSize: getResponsiveText(context, 14),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
