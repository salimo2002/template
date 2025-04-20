import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/home%20view%20widgets/button_check_price.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';
import 'package:template/widgets/home%20view%20widgets/row_custom_button.dart';

class CreateFinancialDocuments extends StatelessWidget {
  const CreateFinancialDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PartsTitle(title: 'انشاء فواتير و سندات جديدة', color: kblueAccent),
          SizedBox(height: 5),
          ButtonCheckPrice(
            title: 'استعلام عن سعر مادة',
            icon: FontAwesomeIcons.solidQuestionCircle,
          ),
          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.fileCirclePlus,
            icon2: FontAwesomeIcons.fileCirclePlus,
            onTap1: () {},
            onTap2: () {},
            text2: 'فاتورة مبيعات جديدة',
            text1: 'فاتورة مشتريات جديدة',
          ),
          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.fileCircleMinus,
            icon2: FontAwesomeIcons.creditCard,
            onTap1: () {},
            onTap2: () {},
            text1: 'فاتورة مرتجعات جديدة',
            text2: 'سند جديد',
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
