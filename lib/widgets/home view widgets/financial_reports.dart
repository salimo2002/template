import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';
import 'package:template/widgets/home%20view%20widgets/row_custom_button.dart';

class FinancialReports extends StatelessWidget {
  const FinancialReports({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PartsTitle(title: 'التقارير المالية', color: kblueAccent),

          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.fileArrowUp,
            icon2: FontAwesomeIcons.creditCard,
            onTap1: () {},
            onTap2: () {},
            text2: 'الأرباح و الخسائر',
            text1: 'ملخص الحركة',
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
