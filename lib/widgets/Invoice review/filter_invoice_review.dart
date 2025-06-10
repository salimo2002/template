import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class FilterInvoiceReview extends StatelessWidget {
  const FilterInvoiceReview({super.key, required this.onTap});
  final VoidCallback onTap;
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
            containerColor: kWhite,
            text: 'مخصص',
            textColor: kBlueAccent,
          ),
        ),
        ContainerFilter(
          height: 55,
          width: MediaQuery.sizeOf(context).width * 0.232,
          containerColor: kWhite,
          text: 'هذا الشهر',
          textColor: kBlueAccent,
        ),
        ContainerFilter(
          height: 55,
          width: MediaQuery.sizeOf(context).width * 0.232,
          containerColor: kWhite,
          text: 'اليوم',
          textColor: kBlueAccent,
        ),
        ContainerFilter(
          height: 55,
          width: MediaQuery.sizeOf(context).width * 0.232,
          containerColor: kBlueAccent,
          text: 'الكل',
          textColor: kWhite,
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
