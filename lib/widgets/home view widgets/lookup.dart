import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';
import 'package:template/widgets/home%20view%20widgets/row_custom_button.dart';

class Lookup extends StatelessWidget {
  const Lookup({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PartsTitle(title: 'الإستعلام عن', color: kblueAccent),

          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.smile,
            icon2: FontAwesomeIcons.boxArchive,
            onTap1: () {},
            onTap2: () {},
            text2: 'حركة مادة',
            text1: 'حركة حساب',
          ),

          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.fileArrowUp,
            icon2: FontAwesomeIcons.boxesPacking,
            onTap1: () {},
            onTap2: () {},
            text1: 'حركة اليومية العامة',
            text2: 'إجمالي حركة المواد',
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
