import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class CustomButtonEditClassifications extends StatelessWidget {
  const CustomButtonEditClassifications({super.key, required this.onTap});
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kBlueAccent,
          borderRadius: BorderRadius.circular(4),
        ),
        width: 125,
        height: 30,
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            'تعديل التصنيف',
            style: FontStyleApp.white18.copyWith(
              fontSize: getResponsiveText(context, 14),
            ),
          ),
        ),
      ),
    );
  }
}
