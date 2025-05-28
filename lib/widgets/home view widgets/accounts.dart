import 'package:flutter/material.dart';
import 'package:template/views/tree_accounts_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class Accounts extends StatelessWidget {
  const Accounts({super.key});

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
                  icon: 'assets/img/home cards/medical-icon_i-billing.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'الزبائن',
                  icon: 'assets/img/home cards/hugeicons_payment-01.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'الموردين',
                  icon: 'assets/img/home cards/hugeicons_payment-02.svg',
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
                text: 'فاتورة مردود مشتريات',
                icon: 'assets/img/home cards/fluent-mdl2_product-variant.svg',
                onTap: () {},
              ),
              CustomButton(
                text: 'المصاريف و الإرادات',
                icon: 'assets/img/home cards/marketeq_bill-dollar.svg',
                onTap: () {},
              ),
            ],
          ),
          Divider(),
          Row(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'الصناديق و البنوك',
                icon: 'assets/img/home cards/hugeicons_payment-01.svg',
                onTap: () {},
              ),
              CustomButton(
                text: 'شجرة الحسابات',
                icon: 'assets/img/home cards/hugeicons_payment-02.svg',
                onTap: () {
                  Navigator.pushNamed(context, TreeAccountsView.id);
                },
              ),
              CustomButton(
                text: 'قائمة كل الحسابات',
                icon: 'assets/img/home cards/hugeicons_payment-02.svg',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
