
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class ContainerItemClassifications extends StatelessWidget {
  const ContainerItemClassifications({
    super.key,
    required this.nameClassificatio, required this.onTap,
  });
  final String nameClassificatio;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){},
      child: Container(
        height: 50,
        width: MediaQuery.sizeOf(context).width * .95,
        decoration: BoxDecoration(
          color: kgrey,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 10),
          child: Text(
            nameClassificatio,
            style: FontStyleApp.black18.copyWith(
              fontSize: getResponsiveText(context, 18),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
