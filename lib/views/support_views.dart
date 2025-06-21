import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/debit%20cubit/debit_cubit.dart';
import 'package:template/cubit/setting%20cubit/setting_cubit.dart';
import 'package:template/models/account_model.dart';
import 'package:template/models/debit_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/widgets/Invoice%20review/filter_invoice_review.dart';
import 'package:template/widgets/invoice%20details%20view/comments_text_field.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class SupportViews extends StatefulWidget {
  const SupportViews({super.key});
  static String id = 'SupportViews';

  @override
  State<SupportViews> createState() => _SupportViewsState();
}

class _SupportViewsState extends State<SupportViews> {
  final FocusNode _focusNode0 = FocusNode();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  final TextEditingController typeSupportController = TextEditingController();
  final TextEditingController _nameAccountController2 = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _curIdController = TextEditingController();

  late DebitModel debit;
  late String debitType;

  List<AccountModel> debtorSearchResults = [];
  List<AccountModel> creditorSearchResults = [];
  bool isSearchingDebtor = false;
  bool isSearchingCreditor = false;
  late Map mapDebit;

  Color color3 = kWhite;
  Color textColor3 = kBlueAccent;
  TextEditingController date1Controler = TextEditingController();
  bool isToDay = false;
  bool canRead = false;
  bool isReBuild = true;
  late int accId;
  late bool isUpdate;
  @override
  void didChangeDependencies() {
    if (isReBuild) {
      mapDebit = ModalRoute.of(context)!.settings.arguments as Map;

      debit = mapDebit['debit'] as DebitModel;
      debitType = debit.ty == 0 ? 'دفع' : 'قبض';
      isUpdate = mapDebit['isUpdat'];
      if (isUpdate) {
        typeSupportController.text = debit.ty == 0 ? 'دفع' : 'قبض';
        context.read<AccountsCubit>().accounts.forEach((element) {
          if (element.accID == debit.accId2) {
            _nameAccountController2.text = element.accName;
            accId = element.accID!;
          }
        });
        _amountController.text = debit.debAmount.toString();
        _curIdController.text = debit.curId == 0 ? 'ليرة سورية' : 'دولار';
        _noteController.text = debit.debNote;
        date1Controler.text =
            '${debit.debDate.year}-${debit.debDate.month}-${debit.debDate.day}';
      }
      typeSupportController.text = 'سند $debitType';
      isReBuild = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'سند ', showIcons: false),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * .15),
                    ContainerFields(
                      children: [
                        CustomTextField(
                          suffixIcon: InkWell(
                            onTapDown: (details) {
                              showTypeSupport(details, typeSupportController);
                            },
                            child: Icon(Icons.arrow_drop_down, size: 40),
                          ),
                          hintText: 'نوع السند',
                          controller: typeSupportController,
                          focusNode: _focusNode0,
                          canRead: true,
                        ),
                        if (isSearchingDebtor)
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: SearchResultsList(
                              results: debtorSearchResults,
                              onSelect: (account) {
                                setState(() {
                                  typeSupportController.text = account.accName;
                                  isSearchingDebtor = false;
                                });
                              },
                            ),
                          ),
                        CustomTextField(
                          onChanged:
                              (query) => searchAccount(query, isDebtor: false),
                          suffixIcon: const SizedBox(width: 40, height: 40),
                          hintText: 'الحساب المقابل',
                          controller: _nameAccountController2,
                          focusNode: _focusNode,
                        ),
                        if (isSearchingCreditor)
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: SearchResultsList(
                              results: creditorSearchResults,
                              onSelect: (account) {
                                setState(() {
                                  _nameAccountController2.text =
                                      account.accName;
                                  accId = account.accID!;
                                  isSearchingCreditor = false;
                                });
                              },
                            ),
                          ),
                        CustomTextField(
                          keyType: TextInputType.numberWithOptions(),
                          hintText: 'المبلغ',
                          controller: _amountController,
                          focusNode: _focusNode2,
                        ),
                        CustomTextField(
                          suffixIcon: InkWell(
                            onTapDown: (TapDownDetails details) {
                              final RenderBox overlay =
                                  Overlay.of(context).context.findRenderObject()
                                      as RenderBox;
                              showMenu(
                                context: context,
                                position: RelativeRect.fromRect(
                                  details.globalPosition & const Size(60, 60),
                                  Offset.zero & overlay.size,
                                ),
                                items: [
                                  PopupMenuItem(
                                    child: Text('ليرة سورية'),
                                    onTap:
                                        () =>
                                            _curIdController.text =
                                                'ليرة سورية',
                                  ),
                                  PopupMenuItem(
                                    child: Text('دولار'),
                                    onTap:
                                        () => _curIdController.text = 'دولار',
                                  ),
                                ],
                              );
                            },
                            child: Icon(Icons.arrow_drop_down, size: 33),
                          ),
                          keyType: TextInputType.numberWithOptions(),
                          hintText: 'العملة',
                          controller: _curIdController,
                          focusNode: _focusNode3,
                          canRead: true,
                        ),
                        CommentsTextField(
                          width: MediaQuery.sizeOf(context).width * 0.75,
                          focusNode: _focusNode4,
                          maxLines: 4,
                          label: 'ملاحظة',
                          controller: _noteController,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isToDay = !isToDay;
                                  if (isToDay) {
                                    color3 = kBlueAccent;
                                    textColor3 = kWhite;
                                    canRead = true;
                                    date1Controler.text = '';
                                  } else {
                                    canRead = false;
                                    color3 = kWhite;
                                    textColor3 = kBlueAccent;
                                  }
                                });
                              },
                              child: ContainerFilter(
                                height: 35,
                                width: MediaQuery.sizeOf(context).width * .22,
                                text: 'تاريخ اليوم',
                                containerColor: color3,
                                textColor: textColor3,
                              ),
                            ),
                            SizedBox(height: 15),

                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: TextFieldDate(
                                canRead: canRead,
                                date: date1Controler,
                                hoursOrYear: true,
                                label: 'تاريخ مخصص',
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButtonSave(
                    label: 'إلغاء',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomButtonSave(
                    label: 'حفظ',
                    onTap: () {
                      if (_curIdController.text == '' ||
                          _amountController.text == '' ||
                          _nameAccountController2.text == '') {
                        print(date1Controler.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(
                            context,
                            'اكمل تعبئة الحقول',
                            Colors.red,
                          ),
                        );
                      } else {
                        if (isUpdate) {
                          context.read<DebitCubit>().updateDebit(
                            DebitModel(
                              debId: debit.debId,
                              voucherNumber: debit.voucherNumber,
                              accId:
                                  context
                                      .read<SettingCubit>()
                                      .settingModel
                                      .mainAccount,
                              accId2: accId,
                              debAmount: double.parse(_amountController.text),
                              ty:
                                  typeSupportController.text == 'سند قبض'
                                      ? 1
                                      : 0,
                              debNote: _noteController.text,
                              curId: _curIdController.text == 'دولار' ? 1 : 0,
                              debDate:
                                  color3 == kWhite
                                      ? DateTime.parse(
                                        fixDateFormat(date1Controler.text),
                                      )
                                      : DateTime.parse(
                                        '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                                      ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                              context,
                              'تمت تعديل السند السند',
                              kBlueAccent,
                            ),
                          );
                          Navigator.pushNamed(
                            context,
                            SupportViews.id,
                            arguments: {
                              'debit': DebitModel(
                                debId: 0,
                                voucherNumber: Random().nextInt(100000),
                                accId:
                                    context
                                        .read<SettingCubit>()
                                        .settingModel
                                        .mainAccount,

                                accId2: 0,
                                debAmount: 0,
                                ty: 0,
                                debNote: '',
                                curId: 0,
                                debDate: DateTime.now(),
                              ),
                              'isUpdat': true,
                            },
                          );
                        } else {
                          context.read<DebitCubit>().insertDebit(
                            DebitModel(
                              debId: 0,
                              voucherNumber: Random().nextInt(100000),
                              accId:
                                  context
                                      .read<SettingCubit>()
                                      .settingModel
                                      .mainAccount,

                              accId2: accId,
                              debAmount: double.parse(_amountController.text),
                              ty:
                                  typeSupportController.text == 'سند قبض'
                                      ? 1
                                      : 0,
                              debNote: _noteController.text,
                              curId: _curIdController.text == 'دولار' ? 1 : 0,
                              debDate:
                                  color3 == kWhite
                                      ? DateTime.parse(date1Controler.text)
                                      : DateTime.parse(
                                        '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                                      ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(
                              context,
                              'تمت إضافة السند',
                              kBlueAccent,
                            ),
                          );
                          Navigator.pushNamed(
                            context,
                            SupportViews.id,
                            arguments: {'debit': debit, 'isUpdat': false},
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String fixDateFormat(String date) {
    final parts = date.split('-');
    if (parts.length == 3) {
      final year = parts[0];
      final month = parts[1].padLeft(2, '0');
      final day = parts[2].padLeft(2, '0');
      return '$year-$month-$day';
    }
    return date; // fallback in case of invalid input
  }

  void showTypeSupport(
    TapDownDetails details,
    TextEditingController controller,
  ) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      menuPadding: EdgeInsets.zero,
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(60, 60),
        Offset.zero & overlay.size,
      ),
      items: [
        CheckedPopupMenuItem(
          child: InkWell(child: Center(child: Text('سند قبض'))),
          onTap: () {
            controller.text = 'سند قبض';
          },
        ),
        CheckedPopupMenuItem(
          child: Center(child: Text('سند دفع')),
          onTap: () {
            controller.text = 'سند دفع';
          },
        ),
      ],
    );
  }

  void searchAccount(String query, {required bool isDebtor}) {
    if (query.isEmpty) {
      setState(() {
        if (isDebtor) {
          debtorSearchResults = [];
          isSearchingDebtor = false;
        } else {
          creditorSearchResults = [];
          isSearchingCreditor = false;
        }
      });
      return;
    }

    final accounts = context.read<AccountsCubit>().accounts;
    final results =
        accounts.where((account) {
          return account.accName.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      if (isDebtor) {
        debtorSearchResults = results;
        isSearchingDebtor = true;
      } else {
        creditorSearchResults = results;
        isSearchingCreditor = true;
      }
    });
  }
}

class SearchResultsList extends StatelessWidget {
  final List<AccountModel> results;
  final void Function(AccountModel) onSelect;

  const SearchResultsList({
    super.key,
    required this.results,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (context, index) {
            final account = results[index];
            return ListTile(
              title: Text(account.accName),
              subtitle: Text(account.accKind.toString()),
              onTap: () => onSelect(account),
            );
          },
        ),
      ),
    );
  }
}
