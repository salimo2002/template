
import 'package:flutter/material.dart';
import 'package:template/utils/responsive_text.dart';

class ContainerItemClassifications extends StatelessWidget {
  const ContainerItemClassifications({
    super.key,
    required this.nameClassificatio, required this.onTap, required this.color,
  });
  final String nameClassificatio;
  final void Function() onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:onTap,
      child: Container(
        height: 45,
        width: MediaQuery.sizeOf(context).width * .95,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: Text(
            nameClassificatio,
            style:TextStyle(fontSize:  getResponsiveText(context, 18),color: const Color.fromARGB(255, 82, 82, 82)),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
