import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

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
          style: ButtonStyle(
            iconColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.grey; // اللون عندما يكون الزر محدد
              }
              return Colors.grey; // اللون عندما يكون الزر غير محدد
            }),
          ),
          value: 1,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
          child: Text('نقدي'),
        ),
        RadioMenuButton<int>(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.grey;
              }
              return Colors.grey;
            }),
          ),
          value: 2,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
          child: Text('اجل'),
        ),
        RadioMenuButton<int>(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.grey;
              }
              return Colors.grey;
            }),
            surfaceTintColor: WidgetStatePropertyAll(kWhite),
            overlayColor: WidgetStatePropertyAll(kWhite)
          ),
          value: 3,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
          },
          child: Text('جزئي'),
        ),
      ],
    );
  }
}