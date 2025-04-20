
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/custom_container.dart';
import 'package:template/widgets/parts_titel.dart';
import 'package:template/widgets/row_custom_button.dart';

class ViewInvoices extends StatelessWidget {
  const ViewInvoices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PartsTitle(
            title: 'استعراض الفواتير',
            color: kblueAccent,
          ),
         
          SizedBox(height: 5),
          RowCustomButton(
            icon1: Icons.file_copy,
            icon2: Icons.file_copy_outlined,
            onTap1: () {},
            onTap2: () {},
            text2: 'استعراض المبيعات',
            text1: 'استعراض المشتريات',
          ),
          SizedBox(height: 5),
          RowCustomButton(
            icon1: Icons.file_download,
            icon2: Icons.dock_sharp,
            onTap1: () {},
            onTap2: () {},
            text1: 'مرتجعات المشتريات',
            text2: 'مرتجعات المبيعات',
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
