import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class ContainerFields extends StatelessWidget {
  const ContainerFields({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kColorBorder,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [bosShadow()],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(spacing: 10, children: children),
        ),
      ),
    );
  }
}
