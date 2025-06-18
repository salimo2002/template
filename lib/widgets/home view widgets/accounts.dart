import 'package:flutter/material.dart';
import 'package:template/views/account_statement_view.dart';
import 'package:template/views/fund_journal_view.dart';
import 'package:template/views/support_views.dart';
import 'package:template/views/tree_accounts_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
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
                  text: 'كشف حساب',
                  icon: 'assets/img/home cards/carbon_product.svg',
                  onTap: () {
                    Navigator.pushNamed(context, AccountStatementView.id);
                  },
                ),
                CustomButton(
                text: 'سند دفع',
                icon: 'assets/img/Home/document-minus-svgrepo-com.svg',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    SupportViews.id,
                    arguments: 'push',
                  );
                },
              ),
                  CustomButton(
                text: 'دليل الحسابات',
                icon: 'assets/img/Home/tree-structure-thin-svgrepo-com.svg',
                onTap: () {
                  Navigator.pushNamed(context, TreeAccountsView.id);
                },
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
                  onTap: () {
                    Navigator.pushNamed(context, FundJournalView.id);
                  },
                ),
                CustomButton(
                  text: 'ارصدة',
                  icon: 'assets/img/Home/comment-dollar-svgrepo-com.svg',
                  onTap: () {},
                ),
                CustomButton(
                  text: 'سند قبض',
                  icon: 'assets/img/Home/document-plus-svgrepo-com.svg',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      SupportViews.id,
                      arguments: 'catch',
                    );
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
