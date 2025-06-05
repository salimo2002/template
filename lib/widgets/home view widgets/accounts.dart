import 'package:flutter/material.dart';
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
                  text: 'دليل الحسابات',
                  icon: 'assets/img/Home/tree-structure-thin-svgrepo-com.svg',
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
