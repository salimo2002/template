import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class RadioMenuButtons extends StatefulWidget {
  const RadioMenuButtons({super.key});

  @override
  State<RadioMenuButtons> createState() => _RadioMenuButtonsState();
}

class _RadioMenuButtonsState extends State<RadioMenuButtons> {
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RadioMenuButton<int>(
          value: 1,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
          child: Text(
            'نقدي',
            style: FontStyleApp.black18.copyWith(
              fontSize: getResponsiveText(context, 12),
            ),
          ),
        ),
        RadioMenuButton<int>(
          value: 2,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
          child: Text(
            'اجل',
            style: FontStyleApp.black18.copyWith(
              fontSize: getResponsiveText(context, 12),
            ),
          ),
        ),
      ],
    );
  }
}
