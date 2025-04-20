import 'package:flutter/material.dart';

class ContainerFields extends StatelessWidget {
  const ContainerFields({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xfff3f3f3),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}
