import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/debit%20cubit/debit_cubit.dart';
import 'package:template/cubit/debit%20cubit/debit_status.dart';
import 'package:template/models/debit_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';

class FundJournalView extends StatefulWidget {
  const FundJournalView({super.key});
  static String id = 'FundJournalView';

  @override
  State<FundJournalView> createState() => _FundJournalViewState();
}

class _FundJournalViewState extends State<FundJournalView> {
  TextEditingController firstDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // مثال على جلب البيانات عند بداية الصفحة
    context.read<DebitCubit>().fetchDebits(
      dateFrom:
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
      dateTo:
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'يومية الصندوق',
        showIcons: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ContainerFields(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: CustomButtonSave(
                          onTap: () async {
                            await context.read<DebitCubit>().fetchDebits(
                              dateFrom:
                                  firstDateController.text.isEmpty
                                      ? '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
                                      : firstDateController.text,
                              dateTo:
                                  lastDateController.text.isEmpty
                                      ? '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
                                      : lastDateController.text,
                            );
                          },
                          label: 'تحديث',
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFieldDate(
                          canRead: false,
                          date: lastDateController,
                          hoursOrYear: true,
                          label: 'الى تاريخ',
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFieldDate(
                          canRead: false,
                          date: firstDateController,
                          hoursOrYear: true,
                          label: 'من تاريخ',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<DebitCubit, DebitStatus>(
                builder: (context, state) {
                  if (state is LoadingStateDebit) {
                    return Center(
                      child: CircularProgressIndicator(color: kBlueAccent),
                    );
                  } else if (state is LoadedDebitsState ||
                      state is SuccessStateDebit) {
                    List<DebitModel> debits = context.read<DebitCubit>().debits;
                    List<String> accName = [];
                    List<DebitModel> debitss = [];

                    for (var element in debits) {
                      if (element.accId2 != 0) {
                        final acc = context
                            .read<AccountsCubit>()
                            .accounts
                            .firstWhere((e) => e.accID == element.accId2);
                        accName.add(acc.accName);
                        debitss.add(element);
                      } else {
                        accName.add('لا يوجد حساب');
                        debitss.add(element);
                      }
                    }

                    return ListView.builder(
                      itemCount: debitss.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: ContainerFields(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: RowInFundJournalView(
                                      lable: ': التاريخ',
                                      value:
                                          '${debitss[index].debDate.year}-${debitss[index].debDate.month}-${debitss[index].debDate.day}',
                                    ),
                                  ),
                                  Expanded(
                                    child: RowInFundJournalView(
                                      lable: ':نوع السند',
                                      value:
                                          debitss[index].ty == 0
                                              ? 'دفع'
                                              : 'قبض',
                                    ),
                                  ),
                                ],
                              ),
                              RowInFundJournalView(
                                lable: ':المبلغ',
                                value: debitss[index].debAmount.toString(),
                              ),
                              RowInFundJournalView(
                                lable: ':الحساب المقابل',
                                value: accName[index],
                              ),
                              RowInFundJournalView(
                                lable: ':العملة',
                                value:
                                    debitss[index].curId == 1
                                        ? 'دولار'
                                        : 'ليرة سورية',
                              ),
                              RowInFundJournalView(
                              lable: ':البيان',
                                value: debitss[index].debNote,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is FaliureStateDebit) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'حدث خطأ اثناء جلب البيانات، أعد المحاولة',
                            style: FontStyleApp.black18.copyWith(
                              fontSize: getResponsiveText(context, 18),
                            ),
                          ),
                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              context.read<DebitCubit>().fetchDebits(
                                dateFrom: firstDateController.text,
                                dateTo: lastDateController.text,
                              );
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: kBlueAccent,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowInFundJournalView extends StatelessWidget {
  const RowInFundJournalView({
    super.key,
    required this.lable,
    required this.value,
  });
  final String lable;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 2,
            style: FontStyleApp.black18.copyWith(
              fontSize: getResponsiveText(context, 15),
            ),
          ),
        ),
        SizedBox(width: 5),
        Text(
          lable,
          style: FontStyleApp.blueAccent18.copyWith(
            fontSize: getResponsiveText(context, 15),
          ),
        ),
      ],
    );
  }
}
