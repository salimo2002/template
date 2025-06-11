import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class FilterInvoiceReview extends StatelessWidget {
  const FilterInvoiceReview({super.key, required this.onTap, required this.omTapMonth, required this.onTapDay, required this.onTapAll, required this.color1, required this.textColor1, required this.color2, required this.textColor2, required this.color3, required this.textColor3, required this.color4, required this.textColor4});
  final VoidCallback onTap;
  final VoidCallback omTapMonth;
  final VoidCallback onTapDay;
  final VoidCallback onTapAll;
  final Color color1;
  final Color textColor1;
  final Color color2;
  final Color textColor2;
  final Color color3;
  final Color textColor3;
  final Color color4;
  final Color textColor4;
  
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: ContainerFilter(
            height: 55,
            width: MediaQuery.sizeOf(context).width * 0.232,
            containerColor: color1,
            text: 'مخصص',
            textColor: textColor1,
          ),
        ),
        InkWell(
          onTap: omTapMonth,
          child: ContainerFilter(
            height: 55,
            width: MediaQuery.sizeOf(context).width * 0.232,
            containerColor: color2,
            text: 'هذا الشهر',
            textColor: textColor2,
          ),
        ),
        InkWell(
          onTap: onTapDay,
          child: ContainerFilter(
            height: 55,
            width: MediaQuery.sizeOf(context).width * 0.232,
            containerColor: color3,
            text: 'اليوم',
            textColor: textColor3,
          ),
        ),
        InkWell(
          onTap: onTapAll,
          child: ContainerFilter(
            
            height: 55,
            width: MediaQuery.sizeOf(context).width * 0.232,
            containerColor: color4,
            text: 'الكل',
            textColor: textColor4,
          ),
        ),
      ],
    );
  }
}

class ContainerFilter extends StatelessWidget {
  const ContainerFilter({
    super.key,
    required this.text,
    required this.containerColor,
    required this.textColor,
    required this.width,
    required this.height,
  });
  final String text;
  final Color containerColor;
  final Color textColor;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        border: Border.all(color: kBlueAccent, width: 1),
      ),
      width: width,
      height: height,
      child: Center(
        child: Text(
          text,
          style: FontStyleApp.blueAccent18.copyWith(
            fontSize: getResponsiveText(context, 14),
            color: textColor,
          ),
        ),
      ),
    );
  }
}
