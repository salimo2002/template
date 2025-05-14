
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/account cubit/accounts_cubit.dart';
import 'package:template/account cubit/accounts_status.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/add_account_and_update_view.dart';

class TreeAccountsView extends StatefulWidget {
  const TreeAccountsView({super.key});
  static String id = 'TreeAccountsView';

  @override
  State<TreeAccountsView> createState() => _TreeAccountsViewState();
}

class _TreeAccountsViewState extends State<TreeAccountsView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'شجرة الحسابات',
          style: FontStyleApp.white18.copyWith(
            fontSize: getResponsiveText(context, 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              isExpanded = !isExpanded;
              setState(() {
                log(isExpanded.toString());
              });
            },
            child: Text(
              'توسيع الكل',
              style: FontStyleApp.white18.copyWith(
                fontSize: getResponsiveText(context, 12),
              ),
            ),
          ),
        ],
        backgroundColor: kBlueAccent,
      ),
      body: SafeArea(
        child: BlocBuilder<AccountsCubit, AccountsStatusAccounts>(
          builder: (context, state) {
            if (state is SuccessStateAccounts) {
              final List<AccountModel> allAccounts = state.accounts;
              final List<AccountModel> rootAccounts =
                  allAccounts.where((acc) => acc.parentId == 0).toList();

              return ListView.builder(
                itemCount: rootAccounts.length,
                itemBuilder: (context, index) {
                  return buildTree(context, rootAccounts[index], allAccounts);
                },
              );
            } else if (state is FaliureStateAccounts) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildTree(
    BuildContext context,
    AccountModel account,
    List<AccountModel> allAccounts,
  ) {
    final children =
        allAccounts.where((acc) => acc.parentId == account.accID).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          iconColor: Colors.transparent,
          collapsedIconColor: Colors.transparent,
          title: GestureDetector(
            onTapDown: (details) => showPopupMenu(details, context, account),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconAndDividerInTree(text: account.accName),
            ),
          ),
          children:
              children
                  .map((child) => buildTree(context, child, allAccounts))
                  .toList(),
        ),
      ),
    );
  }

  void showPopupMenu(
    TapDownDetails details,
    BuildContext context,
    AccountModel account,
  ) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(60, 60),
        Offset.zero & overlay.size,
      ),
      items: [
        CheckedPopupMenuItem(
          child: const Text('بطاقة حساب'),
          onTap: () {
            Navigator.pushNamed(
              context,
              AddAccountAndUpdateView.id,
              arguments: {'account': account, 'isNew': false},
            );
          },
        ),
        CheckedPopupMenuItem(
          child: const Text('حذف حساب'),
          onTap: () {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Row(
                      children: const [
                        Icon(Icons.delete, color: kBlueAccent),
                        SizedBox(width: 7),
                        Text('حذف حساب'),
                      ],
                    ),
                    content: const Text(
                      'هل أنت متأكد أنك تريد حذف هذا الحساب؟',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('إلغاء الأمر'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<AccountsCubit>().deleteAccount(
                            account.accID!,
                          );
                        },
                        child: const Text('نعم'),
                      ),
                    ],
                  ),
            );
          },
        ),
      ],
    );
  }
}

class IconAndDividerInTree extends StatelessWidget {
  const IconAndDividerInTree({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.add, color: Colors.black),
        const SizedBox(width: 10),
        Container(width: 1, height: 40, color: kBlack),
        const SizedBox(width: 10),
        Text(
          text,
          style: FontStyleApp.black18.copyWith(
            fontSize: getResponsiveText(context, 12),
          ),
        ),
      ],
    );
  }
}
