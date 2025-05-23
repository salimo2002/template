import 'package:flutter/material.dart';
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
                  text: 'حركة فواتير',
                  icon: 'assets/img/Home/mynaui_home.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'أرصدة',
                  icon: 'assets/img/Home/mynaui_home.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'كشف حساب',
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
                text: 'تقرير مبيعات',
                icon: 'assets/img/Home/mynaui_home.svg',
                onTap: () {},
              ),
              CustomButton(
                text: 'جرد مستودعات',
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
