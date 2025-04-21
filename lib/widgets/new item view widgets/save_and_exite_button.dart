import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';

class SaveAndExitButton extends StatelessWidget {
  const SaveAndExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        backgroundColor: WidgetStateProperty.all(kBlueAccent),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('حفظ وانهاء', style: FontStyleApp.white18),
    );
  }
}
