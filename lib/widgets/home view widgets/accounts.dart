import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/views/add_account_and_update_view.dart';
import 'package:template/views/tree_accounts_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';
import 'package:template/widgets/home%20view%20widgets/row_custom_button.dart';

class Accounts extends StatelessWidget {
  const Accounts({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PartsTitle(title: 'الحسابات', color: kBlueAccent),

          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.faceSmileBeam,
            icon2: FontAwesomeIcons.grinStars,
            onTap1: () {},
            onTap2: () {},
            text2: 'الزبائن',
            text1: 'الموردين',
          ),
          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.bookmark,
            icon2: FontAwesomeIcons.boxArchive,
            onTap1: () {},
            onTap2: () {},
            text1: 'المصاريف و الإرادات',
            text2: 'الصناديق و البنوك',
          ),
          SizedBox(height: 5),
          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.tree,
            icon2: Icons.list_alt,
            onTap1: () {
              Navigator.pushNamed(context, TreeAccountsView.id);
            },
            onTap2: () {},
            text1: 'شجرة الحسابات',
            text2: 'قائمة كل الحسابات',
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
