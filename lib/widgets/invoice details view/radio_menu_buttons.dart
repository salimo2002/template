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
          style: ButtonStyle(iconColor: WidgetStateProperty.all(kBlueAccent)),
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
          style: ButtonStyle(iconColor: WidgetStateProperty.all(kBlueAccent)),
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
          style: ButtonStyle(iconColor: WidgetStateProperty.all(kBlueAccent)),
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
