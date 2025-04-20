import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });
  final String text;
  final IconData icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * .46,
        height: MediaQuery.sizeOf(context).width * .17,
        decoration: BoxDecoration(
          border: Border.all(color: kblueAccent),
          borderRadius: BorderRadius.circular(5),
          color: kWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Icon(size: 35, color: kblueAccent, icon)),
            SizedBox(height: 10),
            FittedBox(
              child: Text(
                text,
                style: FontStyleApp.black18.copyWith(
                  fontSize: getResponsiveText(context, 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
