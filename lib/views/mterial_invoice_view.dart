import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/bill_details_model.dart';
import 'package:template/models/bill_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/create_a_sales_invoice_view.dart';
import 'package:template/views/home_view.dart';
import 'package:template/widgets/Invoice%20review/bill.dart';

class MterialInvoiceView extends StatefulWidget {
  const MterialInvoiceView({super.key});
  static String id = 'MterialInvoiceView';

  @override
  State<MterialInvoiceView> createState() => _MterialInvoiceViewState();
}

class _MterialInvoiceViewState extends State<MterialInvoiceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'حركة المادة',
        showIcons: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          BlocConsumer<BillCubit, BillStatus>(
            listener: (context, state) {
              if (state is SuccessStateBill) {
                log('message1');
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(context, 'تم الحذف الفاتورة', kBlueAccent),
                );
                Navigator.of(context).pop();
              }
              if (state is FaliureStateBill) {
                log('message2');

                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(context, 'حدث مشكلة اثناء الحذف', kRed),
                );
              }
            },
            builder: (context, state) {
              if (state is SuccessStateBill) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.bill.length,
                    itemBuilder: (context, index) {
                      final List<BillModel> bills = state.bill;
                      final List<BillDetailsModel> bDeatails = state.bDeatails;
                      String accountName = '';
                      context.read<AccountsCubit>().accounts.forEach((element) {
                        if (element.accID == bills[index].accId) {
                          accountName = element.accName;
                        }
                      });
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Bill(
                          onPressedDel: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('تأكيد الحذف'),
                                  content: const Text(
                                    'هل أنت متأكد أنك تريد حذف هذه الفاتورة؟',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                      child: const Text('إلغاء'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        context.read<BillCubit>().billDeletById(
                                          id: bills[index].bilId!,
                                        );
                                      },
                                      child: const Text(
                                        'حذف',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onPressedUP: () {
                            Navigator.pushNamed(
                              context,
                              CreateASalesInvoiceView.id,
                              arguments: {
                                'bill': bills[index],
                                'isNew': false,
                                'BillType': bills[index].bilKind,
                                'cur_id': bills[index].curId,
                                'bDetalis': bDeatails,
                              },
                            );
                          },
                          billType:
                              bills[index].bilKind == 'sell'
                                  ? 'مبيعات'
                                  : bills[index].bilKind == 'buy'
                                  ? 'مشتريات'
                                  : bills[index].bilKind == 'undo_buy'
                                  ? 'مردود مشتريات'
                                  : bills[index].bilKind == 'undo_sell'
                                  ? 'مردود مبيعات'
                                  : bills[index].bilKind == 'order'
                                  ? 'طلب'
                                  : '',
                          paymentStyle:
                              bills[index].payType == 0 ? 'نقدي' : 'آجل',
                          invoiceNumber: bills[index].bilId.toString(),
                          billDate:
                              '${bills[index].bilDate!.year}-${bills[index].bilDate!.month}-${bills[index].bilDate!.day}',
                          billTime:
                              '${bills[index].bilDate!.hour.toString().padLeft(2, '0')}:${bills[index].bilDate!.minute.toString().padLeft(2, '0')}',
                          nameAccuont: accountName,
                          total: bills[index].bilTotal.toString(),
                          amountPaid: bills[index].bilPayment.toString(),
                          reminingAmount: bills[index].bilNet.toString(),
                          note: bills[index].bilNote.toString(),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is LoadingStateBill) {
                return Center(child: CircularProgressIndicator());
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
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeView.id,
                            (route) => false,
                          );
                        },
                        icon: Icon(Icons.refresh, color: kBlueAccent, size: 40),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
