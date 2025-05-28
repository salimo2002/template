import 'package:flutter/widgets.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class FilterInvoiceReview extends StatelessWidget {
  const FilterInvoiceReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContainerFilter(
          containerColor: kWhite,
          text: 'مخصص',
          textColor: kBlueAccent,
        ),
        ContainerFilter(
          containerColor: kWhite,
          text: 'هذا الشهر',
          textColor: kBlueAccent,
        ),
        ContainerFilter(
          containerColor: kWhite,
          text: 'اليوم',
          textColor: kBlueAccent,
        ),
        ContainerFilter(
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
  });
  final String text;
  final Color containerColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        border: Border.all(color: kBlueAccent, width: 1),
      ),
      width: MediaQuery.sizeOf(context).width * 0.232,
      height: 55,
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
