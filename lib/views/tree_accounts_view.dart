import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/account%20service/accounts_cubit.dart';
import 'package:template/account%20service/accounts_status.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/add_account_and_update_view.dart';

class TreeAccountsView extends StatelessWidget {
  const TreeAccountsView({super.key});
  static String id = 'TreeAccountsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          style: FontStyleApp.white18.copyWith(
            fontSize: getResponsiveText(context, 12),
          ),
          'شجرة الحسابات',
        ),
        actions: [
          TextButton(
            onPressed: () {
              //////////
            },
            child: Text(
              style: FontStyleApp.white18.copyWith(
                fontSize: getResponsiveText(context, 12),
              ),
              'توسيع الكل',
            ),
          ),
        ],
        backgroundColor: kBlueAccent,
      ),
      body: SafeArea(
        child: BlocBuilder<AccountsCubit, AccountsStatusAccounts>(
          builder: (context, state) {
            if (state is SuccessStateAccounts) {
              return ListView(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      iconColor: Colors.transparent,
                      collapsedIconColor: Colors.transparent,
                      title: IconAndDividerInTree(text: 'شحرة السحابات'),
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ExpansionTile(
                            iconColor: Colors.transparent,
                            collapsedIconColor: Colors.transparent,
                            title: IconAndDividerInTree(text: "الاصول"),
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: ExpansionTile(
                                  iconColor: Colors.transparent,
                                  collapsedIconColor: Colors.transparent,
                                  title: IconAndDividerInTree(
                                    text: 'الاصول الثابتة (طويلة الامدة)',
                                  ),
                                  children: [
                                    InkWell(
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
                                              child: Text('اضافة حساب'),
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  AddAccountAndUpdateView.id,
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                      child: ListTile(title: Text('التاسيس')),
                                    ),
                                    ListTile(title: Text('معدات و تجهيزات')),
                                    ListTile(title: Text('أثاث و مفروشات')),
                                    InkWell(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ExpansionTile(
                                          iconColor: Colors.transparent,
                                          collapsedIconColor:
                                              Colors.transparent,
                                          title: InkWell(
                                            onTapDown: (details) {
                                              final RenderBox overlay =
                                                  Overlay.of(context).context
                                                          .findRenderObject()
                                                      as RenderBox;
                                              showMenu(
                                                context: context,
                                                position: RelativeRect.fromRect(
                                                  details.globalPosition &
                                                      const Size(60, 60),
                                                  Offset.zero & overlay.size,
                                                ),
                                                items: [
                                                  /////////////////////////////////////////////
                                                  CheckedPopupMenuItem(
                                                    child: Text('اضافة حساب'),
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                        arguments: {
                                                          'account': null,
                                                          'isNew': true,
                                                        },
                                                        context,
                                                        AddAccountAndUpdateView
                                                            .id,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 20,
                                              ),
                                              child: IconAndDividerInTree(
                                                text: 'موردين وزبائن',
                                              ),
                                            ),
                                          ),
                                          children: [
                                            SizedBox(
                                              height: 300,
                                              child: ListView.builder(
                                                itemCount:
                                                    state.accounts.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTapDown: (details) {
                                                      final RenderBox overlay =
                                                          Overlay.of(context)
                                                                  .context
                                                                  .findRenderObject()
                                                              as RenderBox;
                                                      showMenu(
                                                        context: context,
                                                        position:
                                                            RelativeRect.fromRect(
                                                              details.globalPosition &
                                                                  const Size(
                                                                    60,
                                                                    60,
                                                                  ),
                                                              Offset.zero &
                                                                  overlay.size,
                                                            ),
                                                        items: [
                                                          //////////////////////////////
                                                          CheckedPopupMenuItem(
                                                            child: Text(
                                                              'بطاقة حساب',
                                                            ),
                                                            onTap: () {
                                                              Navigator.pushNamed(
                                                                arguments: {
                                                                  'account':
                                                                      state
                                                                          .accounts[index],
                                                                  'isNew':
                                                                      false,
                                                                },

                                                                context,
                                                                AddAccountAndUpdateView
                                                                    .id,
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
                                                                          Icons
                                                                              .delete,
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
                                                    child: ListTile(
                                                      title: Text(
                                                        state
                                                            .accounts[index]
                                                            .accName,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
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
        Icon(Icons.add, color: Colors.black),
        SizedBox(width: 10),
        Container(width: 1, height: 40, color: kBlack),
        SizedBox(width: 10),
        Text(
          style: FontStyleApp.black18.copyWith(
            fontSize: getResponsiveText(context, 12),
          ),
          text,
        ),
      ],
    );
  }
}
