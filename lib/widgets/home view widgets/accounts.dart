import 'package:flutter/material.dart';
import 'package:template/views/tree_accounts_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class Accounts extends StatelessWidget {
  const Accounts({super.key});

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
                  text: 'حساب جديد',
                  icon: 'assets/img/home cards/hugeicons_payment-01.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'دليل الحسابات',
                  icon: 'assets/img/home cards/hugeicons_payment-02.svg',
                  onTap: () {
                    Navigator.pushNamed(context, TreeAccountsView.id);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
