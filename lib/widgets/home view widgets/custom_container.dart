import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child, required this.borderRadius});
  final Widget child;
 final BorderRadius  borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: kColorBorder),
        borderRadius: borderRadius,
        color: kWhite,
      ),
      child: child,
    );
  }
}
