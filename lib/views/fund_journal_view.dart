import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/debit%20cubit/debit_cubit.dart';
import 'package:template/models/debit_model.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
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
  late List<DebitModel> debits;
  List<String> accName = [];
  List<DebitModel> debitss = [];
  @override
  Widget build(BuildContext context) {
    debits = context.read<DebitCubit>().debits;
    for (var element in debits) {
      if (element.debDate ==
          DateTime.parse(
            '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} 00:00:00.000',
          )) {
        log(element.debDate.toString());

        if (element.accId2 != 0) {
          context.read<AccountsCubit>().accounts.forEach((elements) {
            if (elements.accID == element.accId2) {
              accName.add(elements.accName);
              debitss.add(element);
            }
          });
        } else {
          accName.add('لا يوجد حساب');
        }
      }
    }

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'يومية الصندوق',
        showIcons: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: ContainerFields(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: TextFieldDate(
                              canRead: false,
                              date: lastDateController,
                              hoursOrYear: true,
                              label: 'الى تاريخ',
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.3,
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
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: debitss.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: ContainerFields(
                          children: [
                            RowInFundJournalView(
                              lable: ':نوع السند',
                              value: debitss[index].ty == 0 ? 'دفع' : 'قبض',
                            ),
                            RowInFundJournalView(
                              lable: ':المبلغ',
                              value: debitss[index].debAmount.toString(),
                            ),
                            RowInFundJournalView(
                              lable: ':الحساب المقابل',
                              value: accName[index] == '' ? '' : accName[index],
                            ),
                            RowInFundJournalView(
                              lable: ':العملة',
                              value:
                                  debitss[index].curId == 0
                                      ? 'دولار'
                                      : 'ليرة سورية',
                            ),
                            RowInFundJournalView(
                              lable: ':البيان',
                              value: debitss[index].debNote,
                            ),
                          ],
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
