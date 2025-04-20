import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.icon, required this.onTap});
final String text;
final IconData icon;
final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: Container(width: 175,height: 75,
        decoration: BoxDecoration(border: Border.all(color: kblueAccent),
          borderRadius: BorderRadius.circular(5),
          color: kWhite,
        ),
        child: Column(children: [Icon(size: 50,color: kblueAccent, icon),Text(text)]),
      ),
    );
  }
}
