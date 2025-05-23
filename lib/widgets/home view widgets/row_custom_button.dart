import 'package:flutter/material.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class RowCustomButton extends StatelessWidget {
  const RowCustomButton({
    super.key,
    required this.text1,
    required this.text2,
    required this.icon1,
    required this.icon2,
    required this.onTap1,
    required this.onTap2,
    required this.text3,
    required this.icon3,
    required this.onTap3,
  });
  final String text1;
  final String text2;
  final String text3;
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final void Function() onTap1;
  final void Function() onTap2;
  final void Function() onTap3;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(text: text1, icon: icon1, onTap: onTap1),

          CustomButton(text: text2, icon: icon2, onTap: onTap2),
          CustomButton(text: text2, icon: icon2, onTap: onTap2),
        ],
      ),
    );
  }
}
