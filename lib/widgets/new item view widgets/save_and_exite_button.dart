import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';

class SaveAndExitButton extends StatelessWidget {
  const SaveAndExitButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(color: kBlueAccent),
        child: Center(child: Text(text, style: FontStyleApp.white18)),
      ),
    );
  }
}
