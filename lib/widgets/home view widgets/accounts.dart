

import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/custom_container.dart';
import 'package:template/widgets/parts_titel.dart';
import 'package:template/widgets/row_custom_button.dart';

class Accounts extends StatelessWidget {
  const Accounts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PartsTitle(
          title: 'الحسابات',
          color: kblueAccent,
        ),
       
        SizedBox(height: 5),
        RowCustomButton(
          icon1: Icons.file_copy,
          icon2: Icons.file_copy_outlined,
          onTap1: () {},
          onTap2: () {},
          text2: 'الزبائن',
          text1: 'الموردين',
        ),
        SizedBox(height: 5),
        RowCustomButton(
          icon1: Icons.file_download,
          icon2: Icons.dock_sharp,
          onTap1: () {},
          onTap2: () {},
          text1: 'المصاريف و الإرادات',
          text2: 'الصناديق و البنوك',
        ), SizedBox(height: 5),
         SizedBox(height: 5),
        RowCustomButton(
          icon1: Icons.file_download,
          icon2: Icons.dock_sharp,
          onTap1: () {},
          onTap2: () {},
          text1: 'شجرة الحسابات',
          text2: 'قائمة كل الحسابات',
        ), SizedBox(height: 5),
       
      ],
    ),
                  );
  }
}
