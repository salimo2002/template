import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/account%20cubit/accounts_status.dart';
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
  Set<int> expandedAccounts = {};
  UniqueKey _expansionKey = UniqueKey();
  bool isExpanded = false;

  List<AccountModel> allAccounts = [];
  Map<int, List<AccountModel>> accountChildrenMap = {};

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
              setState(() {
                isExpanded = !isExpanded;
                if (isExpanded) {
                  expandedAccounts = accountChildrenMap.keys.toSet();
                } else {
                  expandedAccounts.clear();
                }
                _expansionKey = UniqueKey();
              });
            },
            child: Text(
              isExpanded ? 'طي الكل' : 'توسيع الكل',
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
              allAccounts = state.accounts;

              accountChildrenMap.clear();
              for (var account in allAccounts) {
                accountChildrenMap
                    .putIfAbsent(account.parentId, () => [])
                    .add(account);
              }

              final rootAccounts = accountChildrenMap[0] ?? [];

              return ListView.builder(
                key: _expansionKey,
                itemCount: rootAccounts.length,
                itemBuilder: (context, index) {
                  return buildTree(context, rootAccounts[index]);
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

  Widget buildTree(BuildContext context, AccountModel account) {
    final children = accountChildrenMap[account.accID] ?? [];
    final isTileExpanded = expandedAccounts.contains(account.accID);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(right: children.isEmpty ? 35 : 15),
        child:
            children.isEmpty
                ? ListTile(
                  title: GestureDetector(
                    onTapDown:
                        (details) => showPopupMenu(details, context, account),
                    child: Row(
                      children: [
                        const SizedBox(width: 24), // لا أيقونة
                        Container(width: 1, height: 40, color: kBlack),
                        const SizedBox(width: 10),
                        Text(
                          account.accName,
                          style: FontStyleApp.black18.copyWith(
                            fontSize: getResponsiveText(context, 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : ExpansionTile(
                  key: ValueKey(account.accID),
                  initiallyExpanded: isTileExpanded,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      if (expanded) {
                        expandedAccounts.add(account.accID!);
                      } else {
                        expandedAccounts.remove(account.accID!);
                      }
                    });
                  },
                  iconColor: Colors.transparent,
                  collapsedIconColor: Colors.transparent,
                  title: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Icon(
                          isTileExpanded ? Icons.remove : Icons.add,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Container(width: 1, height: 40, color: kBlack),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTapDown:
                              (details) =>
                                  showPopupMenu(details, context, account),
                          child: Text(
                            account.accName,
                            style: FontStyleApp.black18.copyWith(
                              fontSize: getResponsiveText(context, 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  children:
                      children
                          .map((child) => buildTree(context, child))
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
          child: const Text('إضافة'),
          onTap: () {
            Navigator.pushNamed(
              context,
              AddAccountAndUpdateView.id,
              arguments: {'account': account, 'isNew': true},
            );
          },
        ),
        CheckedPopupMenuItem(
          child: const Text('تعديل'),
          onTap: () {
            Navigator.pushNamed(
              context,
              AddAccountAndUpdateView.id,
              arguments: {'account': account, 'isNew': false},
            );
          },
        ),
        CheckedPopupMenuItem(
          child: const Text('حذف'),
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
