import 'package:flutter/material.dart';
import 'package:template/views/create_a_sales_invoice_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class CreateFinancialDocuments extends StatelessWidget {
  const CreateFinancialDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FittedBox(
            child: Row(
              spacing: 50,
              children: [
                CustomButton(
                  text: 'فاتورة مردود مشتريات',
                  icon: 'assets/img/Home/mynaui_home.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'فاتورة مبيعات',
                  icon: 'assets/img/Home/mynaui_home.svg',
                  onTap: () {
                    Navigator.pushNamed(context, CreateASalesInvoiceView.id);
                  },
                ),
                CustomButton(
                  text: 'فاتورة مشتريات',
                  icon: 'assets/img/Home/mynaui_home.svg',
                  onTap: () {},
                ),
              ],
            ),
          ),
          Row(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'فاتورة طلبات',
                icon: 'assets/img/Home/mynaui_home.svg',
                onTap: () {},
              ),
              CustomButton(
                text: 'فاتورة مردود مبيعات',
                icon: 'assets/img/Home/mynaui_home.svg',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
