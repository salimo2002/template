import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/bill_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/create_a_sales_invoice_view.dart';
import 'package:template/views/home_view.dart';
import 'package:template/widgets/Invoice%20review/bill.dart';
import 'package:template/widgets/invoice%20details%20view/radio_menu_buttons.dart';

class InvoiceReviewView extends StatefulWidget {
  const InvoiceReviewView({super.key});
  static String id = 'InvoiceReviewView';

  @override
  State<InvoiceReviewView> createState() => _InvoiceReviewViewState();
}

class _InvoiceReviewViewState extends State<InvoiceReviewView> {
  late int nameAcuont;
  late String billType;
  late Map mapModalRoute;
  late String date;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mapModalRoute = ModalRoute.of(context)!.settings.arguments as Map;
    nameAcuont = mapModalRoute['nameAcuont'] ?? 0;
    billType = mapModalRoute['billType'] ?? '';
    date = mapModalRoute['dateTime'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: mapModalRoute['title'] ?? 'استعراض الفواتير',
        showIcons: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<BillCubit, BillStatus>(
              builder: (context, state) {
                if (state is SuccessStateBill) {
                  List<BillModel> filteredBills =
                      context.read<BillCubit>().bill.where((bill) {
                        return bill.bilKind == billType &&
                            RadioMenuButtons.payType == bill.payType &&
                            bill.accId == nameAcuont &&
                            '${bill.bilDate!.year}-${bill.bilDate!.month}-${bill.bilDate!.day}' ==
                                date;
                      }).toList();

                  if (filteredBills.isEmpty) {
                    return Center(
                      child: Text(
                        'لا توجد فواتير لعرضها',
                        style: FontStyleApp.black18.copyWith(
                          fontSize: getResponsiveText(context, 18),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredBills.length,
                    itemBuilder: (context, index) {
                      final currentBill = filteredBills[index];
                      final billAmount =
                          (currentBill.bilNet ?? 0) -
                          (currentBill.bilPayment ?? 0);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: GestureDetector(
                          onTapDown: (details) {
                            showMenuu(details, currentBill.bilId!, currentBill);
                          },
                          child: Bill(
                            paymentStyle:
                                currentBill.payType == 0 ? 'نقدي' : 'آجل',
                            invoiceNumber: currentBill.bilId.toString(),
                            billDate:
                                '${currentBill.bilDate!.year}-${currentBill.bilDate!.month}-${currentBill.bilDate!.day}',
                            billTime:
                                '${currentBill.bilDate!.hour}:${currentBill.bilDate!.minute}',
                            nameAccuont:
                                context
                                    .read<AccountsCubit>()
                                    .accounts
                                    .firstWhere(
                                      (acc) => acc.accID == currentBill.accId,
                                    )
                                    .accName,
                            total: currentBill.bilTotal.toString(),
                            amountPaid: currentBill.bilPayment.toString(),
                            reminingAmount: billAmount.toString(),
                            note: decodeToUtf8(currentBill.bilNote ?? ''),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is LoadingStateBill) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'حدث خطأ حاول مجددا',
                          style: FontStyleApp.black18.copyWith(
                            fontSize: getResponsiveText(context, 18),
                          ),
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeView.id,
                              (route) => false,
                            );
                          },
                          icon: const Icon(
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
        ],
      ),
    );
  }

  String decodeToUtf8(String brokenText) {
    final latin1Bytes = latin1.encode(brokenText);
    return utf8.decode(latin1Bytes);
  }

  void showMenuu(TapDownDetails details, int id, BillModel selectedBill) {
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
          child: const Center(child: Text('تعديل')),
          onTap: () {
            Future.delayed(Duration.zero, () {
              Navigator.pushNamed(
                context,
                CreateASalesInvoiceView.id,
                arguments: {
                  'bill': selectedBill,
                  'isNew': false,
                  'BillType': '',
                },
              );
            });
          },
        ),
        CheckedPopupMenuItem(
          child: const Center(child: Text('حذف')),
          onTap: () {
            context.read<BillCubit>().billDeletById(id: id);
          },
        ),
      ],
    );
  }
}
