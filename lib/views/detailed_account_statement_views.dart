import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/bill_details_model.dart';
import 'package:template/models/bill_model.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/views/invoice_review_view.dart';
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
  TapDownDetails? _tapPosition;
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
            listBill.add(context.read<BillCubit>().bill[j]);
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
                            statement: decodeToUtf8(
                              listBill[index].bilNote.toString(),
                            ),
                            rowColor: rowColor,
                            balance: listBillDetails[index].detBouns.toString(),
                            date: listBill[index].bilDate.toString(),
                            amount:
                                listBillDetails[index].detQuantity.toString(),
                            individualPrice:
                                listBillDetails[index].detPrice.toString(),
                            total: listBill[index].bilTotal.toString(),
                          );
                        }),
                      ],
                    );
                  } else if (state is LoadingStateBill) {
                    return Text('sssssssssssssssssssssssssssssss');
                  } else {
                    return Text('data');
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
    _tapPosition = details;
  }

  void _showPopupMenu() {
    if (_tapPosition == null) return;

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _tapPosition!.globalPosition & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          child: const Text('فاتورة'),
          onTap: () {
            Future.delayed(Duration.zero, () {
              Navigator.pushNamed(
                context,
                InvoiceReviewView.id,
                arguments: {
                  'nameAcuont': accountController.text,
                  'billType': 'sell',
                  'title': 'فاتورة....',
                },
              );
            });
          },
        ),
      ],
    );
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
          individualPrice,
          amount,
          statement,
          date,
          balance,
        ];
        return GestureDetector(
          onTapDown: _storeTapPosition,
          onTap: _showPopupMenu,
          behavior: HitTestBehavior.translucent,
          child: TableValues(value: values[index]),
        );
      }),
    );
  }
}
