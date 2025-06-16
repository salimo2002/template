import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class CustomButtonSave extends StatelessWidget {
  const CustomButtonSave({super.key, required this.onTap, required this.label});
  final void Function()? onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          color: kBlueAccent,
          border: Border.all(color: kBlueAccent),
          borderRadius: BorderRadius.circular(16),
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
