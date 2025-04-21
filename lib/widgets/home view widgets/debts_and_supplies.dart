import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';
import 'package:template/widgets/home%20view%20widgets/row_custom_button.dart';

class DebtsAndSupplies extends StatelessWidget {
  const DebtsAndSupplies({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PartsTitle(title: 'الديون و المستحقات', color: kBlueAccent),

          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.fileCircleMinus,
            icon2: FontAwesomeIcons.fileCirclePlus,
            onTap1: () {},
            onTap2: () {},
            text2: 'الديون (لنا)',
            text1: 'المستحقات (علينا)',
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
