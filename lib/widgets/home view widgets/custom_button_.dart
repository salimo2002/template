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
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * .25,
            height: MediaQuery.sizeOf(context).width * .20,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(offset: Offset(1, 0))],
              borderRadius: BorderRadius.circular(5),
              color: kWhite,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Icon(size: 25, color: kBlueAccent, icon)),
              ],
            ),
          ),
          Text(
            text,
            style: FontStyleApp.black18.copyWith(
              fontSize: getResponsiveText(context, 15),
            ),
          ),
        ],
      ),
    );
  }
}
