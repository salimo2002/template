import 'package:flutter/material.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/row_custom_button.dart';

class ViewInvoices extends StatelessWidget {
  const ViewInvoices({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          RowCustomButton(
            text3: 'فاتورة مردود مشتريات',
            icon3: Icons.abc,
            onTap3: () {},
            icon1: Icons.file_copy_outlined,
            icon2: Icons.file_copy_outlined,
            onTap1: () {},
            onTap2: () {},
            text2: 'استعراض المبيعات',
            text1: 'استعراض المشتريات',
          ),
          SizedBox(height: 5),
          RowCustomButton(
            text3: 'فاتورة مردود مشتريات',
            icon3: Icons.abc,
            onTap3: () {},
            icon1: Icons.file_copy_outlined,
            icon2: Icons.file_copy_outlined,
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
