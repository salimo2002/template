import 'package:flutter/material.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class DebtsAndSupplies extends StatelessWidget {
  const DebtsAndSupplies({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 15),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FittedBox(
            child: Row(
              spacing: 50,
              children: [
                CustomButton(
                  text: 'الديون لنا',
                  icon: 'assets/img/home cards/medical-icon_i-billing.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: ' المستحقات علينا',
                  icon: 'assets/img/home cards/hugeicons_payment-01.svg',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
