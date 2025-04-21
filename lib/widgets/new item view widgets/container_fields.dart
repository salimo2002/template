import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class ContainerFields extends StatelessWidget {
  const ContainerFields({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        // height: 100
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xfff3f3f3),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kBlacCustomk),
        ),
        child: Column(children: children),
      ),
    );
  }
}
