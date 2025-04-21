import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: kBlueAccent),
        borderRadius: BorderRadius.circular(5),
        color: kWhite,
      ),
      child: child,
    );
  }
}
