import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class FilterInvoiceReview extends StatefulWidget {
  final VoidCallback onTapCustom;
  final VoidCallback onTapMonth;
  final VoidCallback onTapDay;
  final VoidCallback onTapAll;

  const FilterInvoiceReview({
    super.key,
    required this.onTapCustom,
    required this.onTapMonth,
    required this.onTapDay,
    required this.onTapAll,
  });

  @override
  State<FilterInvoiceReview> createState() => _FilterInvoiceReviewState();
}

class _FilterInvoiceReviewState extends State<FilterInvoiceReview> {
  // 0 -> مخصص
  // 1 -> هذا الشهر
  // 2 -> اليوم
  // 3 -> الكل
  int selectedIndex = 3; // مثلا نبدأ على "الكل"

  void updateSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });

    // استدعاء الدالة المناسبة حسب الزر
    switch (index) {
      case 0:
        widget.onTapCustom();
        break;
      case 1:
        widget.onTapMonth();
        break;
      case 2:
        widget.onTapDay();
        break;
      case 3:
        widget.onTapAll();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // الدالة لاختيار اللون حسب التحديد
    Color getBackgroundColor(int index) {
      return selectedIndex == index ? kBlueAccent : Colors.white;
    }

    Color getTextColor(int index) {
      return selectedIndex == index ? Colors.white : kBlueAccent;
    }

    final double buttonWidth = MediaQuery.sizeOf(context).width * 0.232;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => updateSelectedIndex(0),
          child: ContainerFilter(
            height: 55,
            width: buttonWidth,
            containerColor: getBackgroundColor(0),
            text: 'مخصص',
            textColor: getTextColor(0),
          ),
        ),
        InkWell(
          onTap: () => updateSelectedIndex(1),
          child: ContainerFilter(
            height: 55,
            width: buttonWidth,
            containerColor: getBackgroundColor(1),
            text: 'هذا الشهر',
            textColor: getTextColor(1),
          ),
        ),
        InkWell(
          onTap: () => updateSelectedIndex(2),
          child: ContainerFilter(
            height: 55,
            width: buttonWidth,
            containerColor: getBackgroundColor(2),
            text: 'اليوم',
            textColor: getTextColor(2),
          ),
        ),
        InkWell(
          onTap: () => updateSelectedIndex(3),
          child: ContainerFilter(
            height: 55,
            width: buttonWidth,
            containerColor: getBackgroundColor(3),
            text: 'الكل',
            textColor: getTextColor(3),
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
