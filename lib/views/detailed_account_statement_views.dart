import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/bill_details_model.dart';
import 'package:template/models/bill_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/home_view.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_labels.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_values.dart';

class DetailedAccountStatementView extends StatefulWidget {
  const DetailedAccountStatementView({super.key});
  static String id = 'SupportDetailsViews';

  @override
  State<DetailedAccountStatementView> createState() =>
      _DetailedAccountStatementViewState();
}

class _DetailedAccountStatementViewState
    extends State<DetailedAccountStatementView> {
  TapDownDetails? tapPosition;
  int? accID;
  List<BillDetailsModel> listBillDetails = [];
  List<BillModel> listBill = [];

  @override
  void didChangeDependencies() {
    accID = int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    for (var i = 0; i < context.read<BillCubit>().bill.length; i++) {
      if (accID == context.read<BillCubit>().bill[i].accId) {
        for (var j = 0; j < context.read<BillCubit>().billDetails.length; j++) {
          if (context.read<BillCubit>().billDetails[j].bilId ==
              context.read<BillCubit>().bill[i].bilId) {
            listBillDetails.add(context.read<BillCubit>().billDetails[j]);
            listBill.add(context.read<BillCubit>().bill[i]);
          }
        }
      }
    }
    super.didChangeDependencies();
  }

  final TextEditingController accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'كشف حساب',
        showIcons: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BlocBuilder<BillCubit, BillStatus>(
                builder: (context, state) {
                  if (state is SuccessStateBill) {
                    return Table(
                      defaultColumnWidth: const FixedColumnWidth(100),
                      border: TableBorder(
                        verticalInside: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                        horizontalInside: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1,
                        ),
                      ),
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Colors.white),
                          children: [
                            TableLabels(label: 'الرصيد'),
                            TableLabels(label: 'التاريخ'),
                            TableLabels(label: 'البيان'),
                            TableLabels(label: 'سعر الافرادي'),
                            TableLabels(label: 'الكمية'),
                            TableLabels(label: 'الاجمالي'),
                          ],
                        ),
                        ...List.generate(listBillDetails.length, (index) {
                          final isEven = index % 2 == 0;
                          final rowColor =
                              isEven ? Colors.white : Colors.grey.shade200;
                          return buildDataRow(
                            statement:
                                listBillDetails[index].detSinglePrice
                                    .toString(),
                            rowColor: rowColor,
                            balance: listBillDetails[index].detPrice.toString(),
                            date: listBillDetails[index].detQuantity.toString(),
                            amount:
                                '${listBill[index].bilDate!.year.toString()}/${listBill[index].bilDate!.month.toString()}/${listBill[index].bilDate!.day.toString()}',
                            individualPrice: decodeToUtf8(
                              listBill[index].bilNote.toString(),
                            ),
                            total: '2500',
                          );
                        }),
                      ],
                    );
                  } else if (state is LoadingStateBill) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'حدث خطأ حاول جدداً',
                            style: FontStyleApp.black18.copyWith(
                              fontSize: getResponsiveText(context, 18),
                            ),
                          ),
                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeView.id,
                                (route) => false,
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
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  String decodeToUtf8(String brokenText) {
    final latin1Bytes = latin1.encode(brokenText);
    return utf8.decode(latin1Bytes);
  }

  void _storeTapPosition(TapDownDetails details) {
    tapPosition = details;
  }

  TableRow buildDataRow({
    required Color rowColor,
    required String balance,
    required String date,
    required String total,
    required String individualPrice,
    required String amount,
    required String statement,
  }) {
    return TableRow(
      decoration: BoxDecoration(color: rowColor),
      children: List.generate(6, (index) {
        final values = [
          total,
          amount,
          individualPrice,
          statement,
          date,
          balance,
        ];
        return GestureDetector(
          onTapDown: _storeTapPosition,
          behavior: HitTestBehavior.translucent,
          child: TableValues(value: values[index]),
        );
      }),
    );
  }
}
