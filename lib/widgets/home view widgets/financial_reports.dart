import 'package:flutter/material.dart';
import 'package:template/views/support_views.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class FinancialReports extends StatelessWidget {
  const FinancialReports({super.key});

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
                  text: 'كشف حساب',
                  icon: 'assets/img/home cards/carbon_product.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'جرد مستودعات',
                  icon: 'assets/img/home cards/hugeicons_money-bag-01.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'مبيعات',
                  icon: 'assets/img/home cards/vaadin_money-exchange.svg',
                  onTap: () {},
                ),
              ],
            ),
          ),
          FittedBox(
            child: Row(
              spacing: 50,
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                CustomButton(
                  text: 'يومية الصندوق',
                  icon:
                      'assets/img/home cards/hugeicons_money-receive-circle.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'ارصدة',
                  icon: 'assets/img/home cards/vaadin_storage.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'سند قبض',
                  icon: 'assets/img/home cards/vaadin_storage.svg',
                  onTap: () {
                    Navigator.pushNamed(context, SupportViews.id);
                  },
                ),
              ],
            ),
          ),
          Row(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'سند دفع',
                icon:
                    'assets/img/home cards/hugeicons_money-receive-circle.svg',
                onTap: () {
                  Navigator.pushNamed(context, SupportViews.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
