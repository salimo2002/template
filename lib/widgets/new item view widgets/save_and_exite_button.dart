import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';

class SaveAndExitButton extends StatelessWidget {
  const SaveAndExitButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(color: kBlueAccent),
        child: Center(child: Text('حفظ وإنهاء', style: FontStyleApp.white18)),
      ),
    );
  }
}
