import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/account%20cubit/accounts_cubit.dart';
import 'package:template/account%20cubit/accounts_status.dart';
import 'package:template/models/acconts_get_perint_id_zero.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/add_account_and_update_view.dart';

class TreeAccountsView extends StatelessWidget {
  const TreeAccountsView({super.key});
  static String id = 'TreeAccountsView';

  @override
  Widget build(BuildContext context) {
    List<AccountModel> filterAccounts = [];
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
              //////////
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
              List<AccountModel> allAccounts = state.accounts;
              List<ParentAccountsModel> parentsAccounts = state.parentsAccounts;
              return ListView(
                children: [
                  InkWell(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        iconColor: Colors.transparent,
                        collapsedIconColor: Colors.transparent,
                        title: IconAndDividerInTree(text: 'شجرة الحسابات'),
                        children: [
                          SizedBox(
                            height: 600,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ListView.builder(
                                itemCount: parentsAccounts.length,
                                itemBuilder: (context, indexx) {
                                  return InkWell(
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ExpansionTile(
                                        iconColor: Colors.transparent,
                                        collapsedIconColor: Colors.transparent,
                                        title: InkWell(
                                          onTapDown: (details) {
                                            final RenderBox overlay =
                                                Overlay.of(
                                                      context,
                                                    ).context.findRenderObject()
                                                    as RenderBox;
                                            showMenu(
                                              context: context,
                                              position: RelativeRect.fromRect(
                                                details.globalPosition &
                                                    const Size(60, 60),
                                                Offset.zero & overlay.size,
                                              ),
                                              items: [
                                                CheckedPopupMenuItem(
                                                  child: Text('بطاقة حساب'),
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      AddAccountAndUpdateView
                                                          .id,
                                                      arguments: {
                                                        'account':
                                                            state
                                                                .accounts[indexx],
                                                        'isNew': false,
                                                      },
                                                    );
                                                  },
                                                ),
                                                CheckedPopupMenuItem(
                                                  child: Text('حذف حساب'),
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.delete,
                                                                color:
                                                                    kBlueAccent,
                                                              ),
                                                              SizedBox(
                                                                width: 7,
                                                              ),
                                                              Text('حذف حساب'),
                                                            ],
                                                          ),
                                                          content: Text(
                                                            'هل أنت متأكد أنك تريد حذف هذه الحساب',
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed:
                                                                  () =>
                                                                      Navigator.pop(
                                                                        context,
                                                                      ),
                                                              child: Text(
                                                                'إلغاء الامر',
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                                context
                                                                    .read<
                                                                      AccountsCubit
                                                                    >()
                                                                    .deleteAccount(
                                                                      state
                                                                          .accounts[indexx]
                                                                          .accID!,
                                                                    );
                                                              },
                                                              child: Text(
                                                                'نعم',
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: IconAndDividerInTree(
                                              text:
                                                  parentsAccounts[indexx]
                                                      .namePierint,
                                            ),
                                          ),
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 20,
                                            ),
                                            child: SizedBox(
                                              height: 300,
                                              child: ListView.builder(
                                                itemCount:
                                                    filterAcounts(
                                                      indexx,
                                                      state.accounts,
                                                      state.parentsAccounts,
                                                    ).length,
                                                itemBuilder: (context, index) {
                                                  filterAccounts =
                                                      filterAcounts(
                                                        indexx,
                                                        state.accounts,
                                                        state.parentsAccounts,
                                                      );
                                                  return InkWell(
                                                    child: Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: ExpansionTile(
                                                        iconColor:
                                                            Colors.transparent,
                                                        collapsedIconColor:
                                                            Colors.transparent,
                                                        title: InkWell(
                                                          onTapDown: (details) {
                                                            final RenderBox
                                                            overlay =
                                                                Overlay.of(
                                                                          context,
                                                                        )
                                                                        .context
                                                                        .findRenderObject()
                                                                    as RenderBox;
                                                            showMenu(
                                                              context: context,
                                                              position: RelativeRect.fromRect(
                                                                details.globalPosition &
                                                                    const Size(
                                                                      60,
                                                                      60,
                                                                    ),
                                                                Offset.zero &
                                                                    overlay
                                                                        .size,
                                                              ),
                                                              items: [
                                                                CheckedPopupMenuItem(
                                                                  child: Text(
                                                                    'بطاقة حساب',
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator.pushNamed(
                                                                      context,
                                                                      AddAccountAndUpdateView
                                                                          .id,
                                                                      arguments: {
                                                                        'account':
                                                                            state.accounts[index],
                                                                        'isNew':
                                                                            false,
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                                CheckedPopupMenuItem(
                                                                  child: Text(
                                                                    'حذف حساب',
                                                                  ),
                                                                  onTap: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder: (
                                                                        context,
                                                                      ) {
                                                                        return AlertDialog(
                                                                          title: Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.delete,
                                                                                color:
                                                                                    kBlueAccent,
                                                                              ),
                                                                              SizedBox(
                                                                                width:
                                                                                    7,
                                                                              ),
                                                                              Text(
                                                                                'حذف حساب',
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          content: Text(
                                                                            'هل أنت متأكد أنك تريد حذف هذه الحساب',
                                                                          ),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed:
                                                                                  () => Navigator.pop(
                                                                                    context,
                                                                                  ),
                                                                              child: Text(
                                                                                'إلغاء الامر',
                                                                              ),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(
                                                                                  context,
                                                                                );
                                                                                context
                                                                                    .read<
                                                                                      AccountsCubit
                                                                                    >()
                                                                                    .deleteAccount(
                                                                                      state.accounts[index].accID!,
                                                                                    );
                                                                              },
                                                                              child: Text(
                                                                                'نعم',
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                  right: 10,
                                                                ),
                                                            child: IconAndDividerInTree(
                                                              text:
                                                                  filterAccounts[index]
                                                                      .accName,
                                                            ),
                                                          ),
                                                        ),
                                                        children: [],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is FaliureStateAccounts) {
              return Center(child: Text(state.errorMessage));
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  List<AccountModel> filterAcounts(
    int index,
    List<AccountModel> acc,
    List<ParentAccountsModel> acco,
  ) {
    List<AccountModel> filterAccounts = [];
    for (var i = 0; i < acc.length; i++) {
      if (acc[i].parentId.toString() == acco[index].idPierint) {
        filterAccounts.add(acc[i]);
      }
    }
    return filterAccounts;
  }
}

class IconAndDividerInTree extends StatelessWidget {
  const IconAndDividerInTree({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.add, color: Colors.black),
        SizedBox(width: 10),
        Container(width: 1, height: 40, color: kBlack),
        SizedBox(width: 10),
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
