import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/debit%20cubit/debit_cubit.dart';
import 'package:template/cubit/debit%20cubit/debit_status.dart';
import 'package:template/models/account_model.dart';
import 'package:template/models/debit_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/Invoice%20review/filter_invoice_review.dart';
import 'package:template/widgets/invoice%20details%20view/comments_text_field.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class FundJournalView extends StatefulWidget {
  const FundJournalView({super.key});
  static String id = 'FundJournalView';

  @override
  State<FundJournalView> createState() => _FundJournalViewState();
}

class _FundJournalViewState extends State<FundJournalView> {
  TextEditingController receivablesControler = TextEditingController(text: '');
  TextEditingController paymentsControler = TextEditingController(text: '');
  TextEditingController accountControler = TextEditingController();
  TextEditingController currencyControler = TextEditingController();
  TextEditingController statementControler = TextEditingController();

  ValueNotifier<bool> isPayments = ValueNotifier(false);
  ValueNotifier<bool> isRecipt = ValueNotifier(false);
  int accId = 0;
  List<AccountModel> searchResults = [];
  bool isSearching = false;
  FocusNode receivablesFoucs = FocusNode();
  FocusNode paymentsFoucs = FocusNode();
  FocusNode accountFoucs = FocusNode();
  FocusNode currencyFoucs = FocusNode();
  FocusNode statementFoucs = FocusNode();
  final GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'يومية الصندوق',
          showIcons: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ContainerFields(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ContainerFilter(
                            height: 35,
                            width: MediaQuery.sizeOf(context).width * .22,
                            text: 'تاريخ مخصص',
                            containerColor: kWhite,
                            textColor: kBlueAccent,
                          ),
                          ContainerFilter(
                            height: 35,
                            width: MediaQuery.sizeOf(context).width * .22,
                            text: 'الشهر',
                            containerColor: kWhite,
                            textColor: kBlueAccent,
                          ),
                          ContainerFilter(
                            height: 35,
                            width: MediaQuery.sizeOf(context).width * .22,
                            text: 'اليوم',
                            containerColor: kBlueAccent,
                            textColor: kWhite,
                          ),
                          Flexible(
                            child: Text(
                              ' : حركة ',
                              style: FontStyleApp.blackCustom18.copyWith(
                                fontSize: getResponsiveText(context, 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                ContainerFields(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: isRecipt,
                      builder: (context, value, child) {
                        return CustomTextField(
                          validator: (p0) {
                            if (isRecipt.value) {
                              return null;
                            } else if (p0 == null || p0 == '') {
                              return 'الرجاء ادخال ميلغ';
                            }
                            return null;
                          },
                          onChanged: (p0) {
                            p0 != ''
                                ? isPayments.value = true
                                : isPayments.value = false;
                          },
                          canRead: isRecipt.value,
                          keyType: TextInputType.number,
                          hintText: 'المقبوضات',
                          controller: receivablesControler,
                          focusNode: receivablesFoucs,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: isPayments,
                      builder: (context, value, child) {
                        return CustomTextField(
                          validator: (p0) {
                            if (isPayments.value) {
                              return null;
                            } else if (p0 == null || p0 == '') {
                              return 'الرجاء ادخال ميلغ';
                            }
                            return null;
                          },
                          onChanged: (p0) {
                            p0 != ''
                                ? isRecipt.value = true
                                : isRecipt.value = false;
                          },
                          canRead: isPayments.value,
                          keyType: TextInputType.number,
                          hintText: 'المدفوعات',
                          controller: paymentsControler,
                          focusNode: paymentsFoucs,
                        );
                      },
                    ),
                    CustomTextField(
                      validator: (p0) {
                        if (p0 == null || p0 == '') {
                          return 'الرجاء ادخال اسم الحساب';
                        }
                        return null;
                      },
                      onChanged: searchAccount,
                      hintText: 'الحساب المقابل',
                      controller: accountControler,
                      focusNode: accountFoucs,
                    ),
                    if (isSearching)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              final account = searchResults[index];
                              return ListTile(
                                title: Text(account.accName),
                                subtitle: Text(account.accKind.toString()),
                                onTap: () {
                                  setState(() {
                                    accountControler.text = account.accName;
                                    isSearching = false;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    CustomTextField(
                      validator: (p0) {
                        if (p0 == null || p0 == '') {
                          return 'الرجاء ادخال العملة';
                        }
                        return null;
                      },
                      canRead: true,
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
                                    () => currencyControler.text = 'ليرة سورية',
                              ),
                              PopupMenuItem(
                                child: Text('دولار'),
                                onTap: () => currencyControler.text = 'دولار',
                              ),
                            ],
                          );
                        },
                        child: Icon(Icons.arrow_drop_down, size: 33),
                      ),
                      hintText: 'العملة',
                      controller: currencyControler,
                      focusNode: currencyFoucs,
                    ),
                    CommentsTextField(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      maxLines: 4,
                      label: 'البيان',
                      controller: statementControler,
                      focusNode: statementFoucs,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * .28),
                BlocBuilder<DebitCubit, DebitStatus>(
                  builder: (context, state) {
                    if (state is SuccessStateDebit) {}
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButtonSave(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          label: 'الغاء',
                        ),
                        CustomButtonSave(
                          onTap: () {
                            if (globalKey.currentState!.validate()) {
                              context.read<AccountsCubit>().accounts.forEach((
                                element,
                              ) {
                                if (accountControler.text == element.accName) {
                                  accId = element.accID!;

                                  context.read<DebitCubit>().insertDebit(
                                    DebitModel(
                                      debId: 0,
                                      voucherNumber: Random().nextInt(100000),
                                      accId: 1,
                                      accId2: accId,
                                      debAmount:
                                          receivablesControler.text == ''
                                              ? double.parse(
                                                paymentsControler.text,
                                              )
                                              : double.parse(
                                                receivablesControler.text,
                                              ),
                                      ty: isRecipt.value == true ? 0 : 1,
                                      debNote: statementControler.text,
                                      curId:
                                          currencyControler.text == 'دولار'
                                              ? 1
                                              : 0,
                                      debDate: DateTime.parse(
                                        '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                                      ),
                                    ),
                                  );
                                   
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    FundJournalView.id,
                                    (route) => false,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar(
                                      context,
                                      'تمت الاضافة بنجاح',
                                      kBlueAccent,
                                    ),
                                  );
                                  
                                } else{accId=-1;}
                                
                                
                              });
                              if (accId==-1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnackBar(
                                      context,
                                      'الحساب المقابل غير موجود في الحسابات',
                                      kRed,
                                    ),
                                  );
                              }

                            }
                          },
                          label: 'حفظ',
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchAccount(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      return;
    }

    setState(() {
      isSearching = true;
    });

    final accounts = context.read<AccountsCubit>().accounts;
    final results =
        accounts.where((account) {
          return account.accName.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      searchResults = results;
    });
  }
}
