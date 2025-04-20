import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.icon});
final String text;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: kWhite,
      ),
      child: Column(children: [Icon(color: kblueAccent, icon),Text(text)]),
    );
  }
}
