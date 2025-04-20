
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/custom_container.dart';
import 'package:template/widgets/parts_titel.dart';
import 'package:template/widgets/row_custom_button.dart';

class DebtsAndSupplies extends StatelessWidget {
  const DebtsAndSupplies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         PartsTitle(
           title: 'الديون و المستحقات',
           color: kblueAccent,
         ),
        
         SizedBox(height: 5),
         RowCustomButton(
           icon1: Icons.file_copy,
           icon2: Icons.file_copy_outlined,
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